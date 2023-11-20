import SwiftData

public struct ProductsListRemoteDataSource {
    public func fetch(in modelContext: ModelContext) async throws -> [Product] {
        let productsList: [Product] = load("ProductsList", in: Bundle(identifier: "loghozinsky.Market"))
        let sortedProductList = productsList.sorted(by: { lhs, rhs in
            lhs.creation_date < rhs.creation_date
        })
        try await Task.sleep(nanoseconds: 13_000_000_000) // 3 seconds
        return sortedProductList
    }
}
