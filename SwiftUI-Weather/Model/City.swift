//
//  City.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.01.2020.
//  Copyright © 2020 Antropov. All rights reserved.
//

import Foundation
import CoreData

@objc(City)
public class City: NSManagedObject, Identifiable {
//    static func == (lhs: City, rhs: City) -> Bool {
//        lhs.id == rhs.id
//    }
    
//    internal init(name: String, imageName: String) {
//        self.name = name
//        self.imageName = imageName
//    }
    
//    let id: UUID = UUID()
//    let name: String
//    let imageName: String
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String 
    @NSManaged public var imageName: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
}
