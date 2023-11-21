//
//  CartViewModel.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData
import SwiftUI

public struct CartViewModel {
    public struct Model: Sendable, Identifiable, Hashable {
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
            && lhs.products.count == rhs.products.count
        }
        
        public let id: String
        public let products: [ProductsListViewModel.Model]
        public var isEmpty: Bool {
            products.isEmpty
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(products.count)
        }
        
        public static var empty: Self {
            CartViewModel.Model(id: UUID().uuidString, products: [])
        }
    }
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.locale = .init(Locale(languageCode: "uk-UA"))
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    private var _cartUseCase: CartUseCase
    
    public init(useCase: CartUseCase) {
        _cartUseCase = useCase

    }
    
    private func model(from cart: Cart) -> Model {
        Model(id: cart.id, products: cart.products.map { ProductsListViewModel.model(from: $0) })
    }
    
    public func fetch(in modelContext: ModelContext) async -> Model {
        do {
            return try await model(from: _cartUseCase.fetch(in: modelContext))
        } catch {
            fatalError()
        }
    }
    
    public func save(_ cart: Model, in modelContext: ModelContext) async {
        let cart = Cart(id: cart.id, products: cart.products.map { ProductsListViewModel.entity(from: $0) })
        do {
            try await _cartUseCase.save(cart, in: modelContext)
        } catch {
            fatalError()
        }
    }
}
