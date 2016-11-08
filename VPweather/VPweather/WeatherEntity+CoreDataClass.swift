//
//  WeatherEntity+CoreDataClass.swift
//  VPweather
//
//  Created by Rachid on 08/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import Foundation
import CoreData


public class WeatherEntity: NSManagedObject
{
    class func addAllWeathersInDatabase(weather : Weather, inManagedObjectContext context : NSManagedObjectContext) {
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "WeatherEntity", into: context) as? WeatherEntity {
            entity.clouds = Int64(weather.clouds)
            entity.date = weather.date
            entity.descriptions = weather.description
            entity.grndlvl = weather.grndlvl
            entity.humidity = weather.humidity
            entity.icon = weather.icon
            entity.sealvl = weather.sealvl
            entity.temp = Int64(weather.temperatur)
            entity.tempMax = Int64(weather.tempMax)
            entity.time = weather.time
            entity.timestamp = weather.timestamp
            entity.wind = weather.wind
        }
    }
    
    
    class func getAllWeatherFromDatabase(inManagedObjectContext context : NSManagedObjectContext) -> [Weather]? {
        var weathersDatabase : [Weather] = []
        
        let request : NSFetchRequest<WeatherEntity> = NSFetchRequest(entityName: "WeatherEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        do {
            let queryResuls = try request.execute()
            for weatherInfo in queryResuls {
           
                weathersDatabase.append(Weather(
                    description: weatherInfo.descriptions!,
                    temperatur: Int(weatherInfo.temp),
                    humidity: weatherInfo.humidity,
                    wind: weatherInfo.wind,
                    clouds: Int(weatherInfo.clouds),
                    date: weatherInfo.date!,
                    time: weatherInfo.time!,
                    timestamp: weatherInfo.timestamp,
                    sealvl: weatherInfo.sealvl,
                    grndlvl: weatherInfo.grndlvl,
                    tempMax: Int(weatherInfo.tempMax),
                    icon: weatherInfo.icon!)
                )
            }
            
            return weathersDatabase
            
        } catch _ {
            return nil
        }
    }
    
    class func deleteAllWeatherFromDatabase(inManagedObjectContext context : NSManagedObjectContext) {
        
        let request : NSFetchRequest<WeatherEntity> = NSFetchRequest(entityName: "WeatherEntity")
        do {
            let queryResuls = try request.execute()
            
            for weatherInfo in queryResuls {
                 context.delete(weatherInfo)
            }
        } catch _ {
        }
    }
    
}
