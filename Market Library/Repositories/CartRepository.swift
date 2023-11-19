//
//  CartRepository.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData

public struct CartRepository {
    let dataSource: CartDataBaseDataSource
    
    func fetch(in modelContext: ModelContext) async throws -> Cart {
        try await dataSource.fetch(in: modelContext)
    }
    
    func add(product: Product, in modelContext: ModelContext) async throws -> Cart {
        try await dataSource.add(product: product, in: modelContext)
    }
    
    func delete(product: Product, in modelContext: ModelContext) async throws -> Cart {
        try await dataSource.delete(product: product, in: modelContext)
    }
}

