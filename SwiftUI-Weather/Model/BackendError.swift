//
//  BackendError.swift
//  Weather
//
//  Created by Andrey Antropov on 22/12/2019.
//  Copyright © 2019 Morizo. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case cityNotFound(message: String)
}

extension BackendError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .cityNotFound(message):
            return NSLocalizedString(message, comment: "")
        }
    }
}

enum ApplicationError: Error {
    case loginInputIncorrect(message: String)
}

extension ApplicationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .loginInputIncorrect(message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
