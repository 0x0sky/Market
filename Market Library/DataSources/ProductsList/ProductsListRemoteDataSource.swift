//
//  ProductsListRemoteDataSource.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData

public struct ProductsListRemoteDataSource {
    public func fetch(in modelContext: ModelContext) async throws -> [Product] {
        try await Task.sleep(nanoseconds: 3_000_000_000) // 3 seconds
        let productsList: [Product] = load("ProductsList", in: Bundle(identifier: "com.loghozinsky.market.library"))
        let sortedProductList = productsList.sorted(by: { lhs, rhs in
            lhs.creation_date < rhs.creation_date
        })
        return sortedProductList
    }
}
