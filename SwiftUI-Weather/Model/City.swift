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
    @NSManaged public var id: UUID
    @NSManaged public var name: String 
    @NSManaged public var imageName: String
    
    @nonobjc public class func create(in context: NSManagedObjectContext, name: String, imageName: String?) throws {
        let city = City(context: context)
        city.name = name
        city.id = UUID()
        city.imageName = imageName ?? "default"
        try context.save()
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
}
