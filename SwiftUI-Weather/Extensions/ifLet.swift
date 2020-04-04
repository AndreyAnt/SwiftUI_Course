//
//  ifLet.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import SwiftUI

func ifLet<Value, Content: View>(_ value: Value?, content: (Value) -> Content) -> some View {
    Group {
        if value != nil {
            content(value!)
        }
    }
}
