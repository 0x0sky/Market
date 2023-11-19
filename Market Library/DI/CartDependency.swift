//
//  CartDependency.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftUI

@propertyWrapper
public struct CartDependency<Value>: DynamicProperty {
    @EnvironmentObject private var dependencyContainer: CartDependenciesContainer
    
    public var wrappedValue: Value {
        get {
            dependencyContainer[keyPath: key]
        }
        nonmutating set {
            dependencyContainer[keyPath: key] = newValue
        }
    }
    
    private let key: ReferenceWritableKeyPath<CartDependenciesContainer, Value>
    
    public init(_ key: ReferenceWritableKeyPath<CartDependenciesContainer, Value>) {
        self.key = key
    }
}
