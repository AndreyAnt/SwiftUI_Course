//
//  Publishers+Extension.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 04.04.2020.
//  Copyright © 2020 Antropov Personal. All rights reserved.
//

import UIKit
import Combine

public extension Publishers {
    static let keyboardHeight = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
            .map { $0.size.height },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ -> CGFloat in 0 }
    ).removeDuplicates()
}
