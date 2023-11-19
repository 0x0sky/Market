//
//  ProductsListDataBaseDataSource.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData

struct ProductsListDataBaseDataSource {
    func fetch(in modelContext: ModelContext) async throws -> [Product] {
        let descriptor = FetchDescriptor<Product>(sortBy: [SortDescriptor(\Product.creation_date)])
        let optionalCart = try modelContext.fetch(descriptor)
        return optionalCart
    }
    
    func add(product: Product, in modelContext: ModelContext) async throws -> Cart  {
        let descriptor = FetchDescriptor<Cart>()
        let cart: Cart = try modelContext.fetch(descriptor).first ?? .empty
        dump(cart)
        if !cart.products.map(\.id).contains(product.id){
            cart.modelContext?.autosaveEnabled = true
            cart.products.append(product)
            print(cart.products.map(\.name))
            try modelContext.deleteAll(model: Cart.self)
            modelContext.insert(cart)
            let persistentModelID = cart.persistentModelID
            dump(persistentModelID)
            try modelContext.save()
        }
        return cart
    }
    
    func delete(product: Product, in modelContext: ModelContext) async throws -> Cart {
        let descriptor = FetchDescriptor<Cart>()
        if let cart = try modelContext.fetch(descriptor).first {
            let products = cart.products.filter { $0.id != product.id }
            let cart = try modelContext.fetch(descriptor).first
            cart!.products = products
            modelContext.insert(cart!)
            return cart!
        }
        return .empty
    }
}

public extension ModelContext {
    func deleteAll<T>(model: T.Type) throws where T : PersistentModel {
        let p = #Predicate<T> { _ in true }
        try delete(model: T.self, where: p, includeSubclasses: false)
    }
}
