//
//  WeatherEntity+CoreDataProperties.swift
//  VPweather
//
//  Created by Rachid on 08/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity");
    }

    //  MARK - All Properties in DataBase (CoreData) 
    @NSManaged public var descriptions: String?
    @NSManaged public var temp: Int64
    @NSManaged public var tempMax: Int64
    @NSManaged public var icon: String?
    @NSManaged public var humidity: Double
    @NSManaged public var wind: Double
    @NSManaged public var clouds: Int64
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var timestamp: Double
    @NSManaged public var sealvl: Double
    @NSManaged public var grndlvl: Double

}
