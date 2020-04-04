//
//  City.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.01.2020.
//  Copyright © 2020 Antropov. All rights reserved.
//

import Foundation

class City: Identifiable, Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
    
    internal init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    let id: UUID = UUID()
    let name: String
    let imageName: String
}
