//
//  ForecastViewModel.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import SwiftUI
import RealmSwift

class ForecastViewModel: ObservableObject {
    // Отображаемый город
    let city: City
    // Паблишер для подписки в SwiftUI.View
    let objectWillChange = ObjectWillChangePublisher()
    // Результаты запроса в БД
    private(set) lazy var weathers: Results<Weather>? = try? RealmService.get(Weather.self).filter("id CONTAINS[cd] %@", city.name)
    // Копия результата запроса в БД
    var detachedWeathers: [Weather] { weathers?.map { $0.unmanagedCopy() } ?? [] }
    // Токен-обсервер БД
    private var notificationToken: NotificationToken?
    
    /// В инициализаторе вешаем обсервер на результаты из базы данных
    init(city: City) {
        self.city = city
        
        notificationToken = weathers?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
