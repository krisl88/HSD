//
//  Core.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import Foundation

enum APIError: Error {
    case unableToDecode
    case unableToEncode
    case networkError(Error?)
}

typealias Closure = () -> Void
typealias Callback<T> = (T) -> Void
typealias APICallback<T> = (Result<T, APIError>) -> Void

