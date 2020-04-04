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
    // Паблишер для подписки в SwiftUI.View
    let objectWillChange = ObjectWillChangePublisher()
    // Результаты запроса в БД
    let weathers: Results<Weather>? = try? RealmService.get(Weather.self)
    // Копия результата запроса в БД
    var detachedWeathers: [Weather] { weathers?.map { $0.unmanagedCopy() } ?? [] }
    // Токен-обсервер БД
    private var notificationToken: NotificationToken?
    
    /// В инициализаторе вешаем обсервер на результаты из базы данных
    init() {
        notificationToken = weathers?.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
