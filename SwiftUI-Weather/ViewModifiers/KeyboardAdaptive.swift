//
//  KeyboardAdaptive.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

public struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    public let bottomOffset: CGFloat

    public func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 - self.bottomOffset }
            .animation(.default)
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(bottomOffset: 20))
    }
}
