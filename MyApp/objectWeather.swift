//
//  objectWeather.swift
//  MyApp
//
//  Created by Phan Quy Ky on 3/17/16.
//  Copyright © 2016 Phan Quy Ky. All rights reserved.
//

@objc(dataWeather)

class objectWeather: NSManagedObject {
    
    @NSManaged var desc: String
    @NSManaged var hunidity: String
    @NSManaged var tempC: String
    @NSManaged var time: String
    @NSManaged var url: String
    @NSManaged var windSpeed: String

}
