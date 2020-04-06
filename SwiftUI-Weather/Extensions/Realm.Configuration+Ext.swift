//
//  Realm.Configuration+Ext.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 06.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import RealmSwift

extension Realm.Configuration {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
}
