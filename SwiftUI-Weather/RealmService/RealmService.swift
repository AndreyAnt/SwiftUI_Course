//
//  RealmService.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func get<T: Object>(
        _ type: T.Type,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws -> Results<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
    
    /// Функция получения массива всех объектов указанного типа из хранилища
    static func get<T: Object>(
        _ type: T.Type,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws -> Array<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type).map { $0.unmanagedCopy() }
    }
    
    static func delete<T: Object>(
        object: T,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        try realm.write {
            realm.delete(object)
        }
    }
}
