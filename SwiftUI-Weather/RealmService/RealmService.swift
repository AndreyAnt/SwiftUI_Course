//
//  RealmService.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import Foundation
import RealmSwift

protocol AnyRealmService {
    func save<T: Object>(items: [T], configuration: Realm.Configuration, update: Realm.UpdatePolicy) throws
    func get<T: Object>(_ type: T.Type, configuration: Realm.Configuration) throws -> Results<T>
    func get<T: Object>(_ type: T.Type, configuration: Realm.Configuration) throws -> [T]
    func delete<T: Object>(object: T, configuration: Realm.Configuration) throws
}

class RealmService: AnyRealmService {
    func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = .deleteIfMigration,
        update: Realm.UpdatePolicy = .modified
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    func get<T: Object>(
        _ type: T.Type,
        configuration: Realm.Configuration = .deleteIfMigration
    ) throws -> Results<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
    
    func get<T: Object>(
        _ type: T.Type,
        configuration: Realm.Configuration = .deleteIfMigration
    ) throws -> Array<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type).map { $0.detached() }
    }
    
    func delete<T: Object>(
        object: T,
        configuration: Realm.Configuration = .deleteIfMigration
    ) throws {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(object)
        }
    }
}
