//
//  DateFormatter+Ext.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 18.01.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func forecastFormat(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, HH:mm"
        return dateFormatter.string(from: date)
    }
}
