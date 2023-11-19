//
//  CartDependenciesContainer.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

public class CartDependenciesContainer: ObservableObject {
    public var injector = CartInjector()
    
    public init(){}
}
