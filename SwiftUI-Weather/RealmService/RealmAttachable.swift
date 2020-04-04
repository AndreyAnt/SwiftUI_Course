//
//  RealmAttachable.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import RealmSwift

/// Позволяет получить копию объекта для последующей работы без указания начала и конца транзакции
public protocol RealmAttachable {
    /// Функция возвращает копию объекта
    func unmanagedCopy() -> Self
    /// Функция возвращает копию объекта для конкретного хранилища
    func managedCopy(in realm: Realm) -> Self
}

extension List: RealmAttachable {
    
    /// Функция возвращает копию листа
    public func unmanagedCopy() -> List<Element> {
        let result = List<Element>()
        forEach {
            if let attachable = $0 as? RealmAttachable,
                let copy = attachable.unmanagedCopy() as? Element {
                result.append(copy)
            } else {
                result.append($0)
            }
        }
        return result
    }
    
    /// Функция возвращает копию листа для конкретного хранилища
    public func managedCopy(in realm: Realm) -> List<Element> {
        let result = List<Element>()
        forEach {
            if let attachable = $0 as? RealmAttachable,
                let copy = attachable.managedCopy(in: realm) as? Element {
                result.append(copy)
            } else {
                result.append($0)
            }
        }
        return result
    }
}

extension Object: RealmAttachable {
    /// Функция возвращает копию объекта
    public func unmanagedCopy() -> Self {
        return type(of: self).makeUnamanagedCopy(of: self)
    }
    
    /// Функция возвращает копию объекта для конкретного хранилища
    public func managedCopy(in realm: Realm) -> Self {
        return type(of: self).makeManagedCopy(of: self, in: realm)
    }
    
    /// Функция создает копию объекта
    public static func makeUnamanagedCopy<T>(of object: T) -> T where T: Object {
        let copyObject = T()
        
        for property in copyObject.objectSchema.properties {
            guard let value = object.value(forKey: property.name) else { continue }
            if let nestedObject = value as? RealmAttachable {
                copyObject.setValue(nestedObject.unmanagedCopy(), forKey: property.name)
            } else {
                copyObject.setValue(value, forKey: property.name)
            }
        }
        
        return copyObject
    }
    
    /// Функция создает копию объекта для конкретного хранилища
    public static func makeManagedCopy<T>(of object: T, in realm: Realm) -> T where T: Object {
        var copyObject: T
        if let key = T.primaryKey(),
            let value = object.value(forKey: key),
            let managedObject = realm.object(ofType: T.self, forPrimaryKey: value) {
            copyObject = managedObject
        } else {
            copyObject = makeUnamanagedCopy(of: object)
            realm.add(copyObject)
        }
        return copyObject
    }
}
