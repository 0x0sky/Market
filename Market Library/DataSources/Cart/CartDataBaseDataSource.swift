//
//  CartDataBaseDataSource.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData

struct CartDataBaseDataSource {
    func fetch(in modelContext: ModelContext) async throws -> Cart {
        let descriptor = FetchDescriptor<Cart>()
        let cart = try modelContext.fetch(descriptor).first ?? .empty
        dump(cart.products)
        try! cart.modelContext?.save()
        try! modelContext.save()
        return cart
    }
    
    func add(product: Product, in modelContext: ModelContext) async throws -> Cart {
        let cart = try await fetch(in: modelContext)
        cart.products.append(product)
        modelContext.insert(cart)
        return cart
    }
    
    func delete(product: Product, in modelContext: ModelContext) async throws -> Cart {
        let products = try await fetch(in: modelContext).products.filter { $0.id != product.id }
        let cart = try await fetch(in: modelContext)
        cart.products = products
        modelContext.insert(cart)
        return cart
    }
    
    func save(_ cart: Cart, in modelContext: ModelContext) async throws -> Cart {
        modelContext.insert(cart)
        return cart
    }
}
