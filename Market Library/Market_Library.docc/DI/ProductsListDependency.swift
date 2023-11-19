//
//  ProductsListDependency.swift
//  Market
//
//  Created by Oleksander Lohozinskyi on 17.11.2023.
//

import SwiftUI

@propertyWrapper
public struct ProductsListDependency<Value>: DynamicProperty {
    @EnvironmentObject private var dependencyContainer: ProductsListDependenciesContainer
    
    public var wrappedValue: Value {
        get {
            dependencyContainer[keyPath: key]
        }
        nonmutating set {
            dependencyContainer[keyPath: key] = newValue
        }
    }
    
    private let key: ReferenceWritableKeyPath<ProductsListDependenciesContainer, Value>
    
    public init(_ key: ReferenceWritableKeyPath<ProductsListDependenciesContainer, Value>) {
        self.key = key
    }
}
