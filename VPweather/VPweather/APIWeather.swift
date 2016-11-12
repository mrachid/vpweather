//
//  APIWeather.swift
//  VPweather
//
//  Created by Rachid on 07/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class APIWeather {

    // PROPERTIES POUR LA REQUEST
    private let apiKey = ""
    private let lang = "fr"
    private let units = "metric"
    private let city = "Paris"

    // PROPERTIES DE LA CLASS
    private var managedObjectContext : NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var today = Date().description.components(separatedBy: " ")
    
    private var allWeathers : [Weather] = []
    var listWeathers = [weatherStruct]()
    
    struct weatherStruct {
        var sectionName : String!
        var sectionObjects : [Weather]!
    }
    

    
    //MARK : REQUEST OPEN  WEATHER MAP
    
    func getWeather(completionHandler: @escaping (String) -> ()) {
        
        let urlRequest = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=\(units)&lang=\(lang)&mode=json&appid=\(apiKey)"
        
        Alamofire.request(urlRequest).responseJSON{ response in
            switch response.result {
            case .success:
                self.clearDatabase()

                let data = JSON(response.result.value)
                self.parserWeatherInfo(data: data)
                self.addAllWeatherInDatabase()
                completionHandler("SUCCESS")
                
            case .failure( _):
                self.getWeathersInfoInDatabase()
                if self.listWeathers.count > 0 {
                    completionHandler("SUCCESS")
                }
                else{
                    completionHandler("FAILURE")
                }
            }
            
        }
    }

    
    
    //MARK : PARSING FOR WEATHER INFO
    
    private func parserWeatherInfo(data: JSON) {
        for (_,subJson):(String, JSON) in data["list"] {
            allWeathers.append(Weather(data: subJson))
        }
        addInListWeather()
    }

    private func addInListWeather(){
        var donnes : [Weather] = []
        var date = today.first
        
        for value in allWeathers {
            if date != value.date{
                if donnes.count > 0 {
                    listWeathers.append(weatherStruct(sectionName: date, sectionObjects: donnes))
                }
                donnes.removeAll()
                date = value.date
            }
            donnes.append(value)
        }
        if donnes.count > 0 {
            listWeathers.append(weatherStruct(sectionName: date, sectionObjects: donnes))
        }
    }

    
    
    //MARK : DISPLAY DATE FOR TABLEVIEW
    
    func dateFormatDisplay(data: Weather) -> String{
 
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateObj = dateFormatter.date(from: data.date)
        
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMdd")
        
        return dateFormatter.string(from: dateObj!)
    }
    
    
    
    //MARK : CORE DATA METHODE
    
    private func getWeathersInfoInDatabase(){
        allWeathers.removeAll()
        managedObjectContext?.performAndWait({
            self.allWeathers = WeatherEntity.getAllWeatherFromDatabase(inManagedObjectContext: self.managedObjectContext!)!
            self.addInListWeather()
        })
        
    }
    
    private func clearDatabase(){
        managedObjectContext?.performAndWait({
            WeatherEntity.deleteAllWeatherFromDatabase(inManagedObjectContext: self.managedObjectContext!)
            do{
                try self.managedObjectContext?.save()
            }catch let error{
                print("ERREUR SAVE CONTEXT : \(error)")
            }
        })
        
    }
    
    
    private func addAllWeatherInDatabase(){
        managedObjectContext?.perform({
            for weatherInfo in self.allWeathers {
                WeatherEntity.addAllWeathersInDatabase(weather: weatherInfo, inManagedObjectContext: self.managedObjectContext!)
            }
            do{
                try self.managedObjectContext?.save()
            }catch let error{
                print("ERREUR SAVE CONTEXT : \(error)")
            }
        })
    }
    
    private func displayCountWeatherFromDatabase(){
        managedObjectContext?.perform({
            if let weatherCount = try? self.managedObjectContext?.count(for: NSFetchRequest(entityName: "WeatherEntity")){
                print("Weather count in database : \(weatherCount)")
            }
        })
    }
    
}
