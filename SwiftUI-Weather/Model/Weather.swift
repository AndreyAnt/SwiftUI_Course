//
//  Weather.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 06.01.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import Foundation
import SwiftyJSON
//class Weather: Identifiable {
//    internal init(temperature: Double, date: Date, icon: String) {
//        self.temperature = temperature
//        self.date = date
//        self.icon = icon
//    }
//
//    let id: UUID = UUID()
//    let temperature: Double
//    let date: Date
//    let icon: String
//}

class Weather: Identifiable {
    var id: String = ""
    var date: Date = Date.distantPast
    var temperature: Double = 0
    var pressure: Double = 0
    
    var icon: String = ""
    var iconUrl: URL? {
        URL(string: "https://api.openweathermap.org/img/w/\(icon).png")
    }
    var descr: String = ""
    
//    var cities = LinkingObjects(fromType: City.self, property: "weathers")
    
    convenience init(from json: JSON, city: String) {
        self.init()
        
        let dateDouble = json["dt"].doubleValue
        self.date = Date(timeIntervalSince1970: dateDouble)
        
        self.temperature = json["main"]["temp"].doubleValue
        self.pressure = json["main"]["pressure"].doubleValue
        
        self.icon = json["weather"][0]["icon"].stringValue
        self.descr = json["weather"][0]["description"].stringValue
        self.id = city + String(dateDouble)
    }
    
    convenience init(temperature: Double) {
        self.init()
        
        self.temperature = temperature
    }
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}