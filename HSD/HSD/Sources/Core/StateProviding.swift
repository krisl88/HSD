//
//  StateProviding.swift
//  HSD
//
//  Created by Kris on 7/8/24.
//

import Combine

protocol StateProviding {
    associatedtype State
    var statePublisher: AnyPublisher<State, Never> { get }
}
