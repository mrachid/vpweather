//
//  weather.swift
//  VPweather
//
//  Created by Rachid on 07/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weather {
    
    var description : String
    var temperatur : Int
    var humidity : Double
    var wind : Double
    var clouds : Int
    var date : String
    var time : String
    var timestamp : Double
    var sealvl : Double
    var grndlvl : Double
    var tempMax : Int
    var icon : String
    
    
    init(data : JSON) {
        
        description = data["weather"][0]["description"].stringValue
        temperatur = data["main"]["temp"].intValue
        humidity = data["main"]["humidity"].doubleValue
        wind = data["main"]["wind"]["speed"].doubleValue
        clouds = data["main"]["clouds"]["all"].intValue
        timestamp = data["dt"].doubleValue
        sealvl = data["main"]["sea_level"].doubleValue
        grndlvl = data["main"]["grnd_level"].doubleValue
        tempMax = data["main"]["temp_max"].intValue
        icon = data["weather"][0]["icon"].stringValue
        
        let newDate = data["dt_txt"].stringValue.components(separatedBy: " ")
        date = newDate.first!
        time = newDate.last!
        
    }
    
    init(description : String, temperatur : Int, humidity : Double, wind : Double, clouds : Int, date : String, time : String, timestamp : Double, sealvl : Double, grndlvl : Double, tempMax : Int, icon : String){
        self.description = description
        self.temperatur = temperatur
        self.humidity = humidity
        self.wind = wind
        self.clouds = clouds
        self.date = date
        self.time = time
        self.timestamp = timestamp
        self.sealvl = sealvl
        self.grndlvl = grndlvl
        self.tempMax = tempMax
        self.icon = icon
    }
}
