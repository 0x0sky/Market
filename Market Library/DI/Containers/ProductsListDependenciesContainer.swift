//
//  ProductsListDependenciesContainer.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

public class ProductsListDependenciesContainer: ObservableObject {
    public var injector = ProductsListInjector()
    
    public init(){}
}
