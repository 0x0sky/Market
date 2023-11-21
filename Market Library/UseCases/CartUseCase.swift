//
//  CartUseCase.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData

public struct CartUseCase {
    public let repository: CartRepository
    
    public func fetch(in modelContext: ModelContext) async throws -> Cart {
        try await repository.fetch(in: modelContext)
    }
    
    public func save(_ cart: Cart, in modelContext: ModelContext) async throws -> Cart {
        try await repository.save(cart, in: modelContext)
    }
}
