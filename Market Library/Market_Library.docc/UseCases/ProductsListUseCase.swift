import SwiftData

public struct ProductsListUseCase {
    let repository: ProductsListRepository
    
    public func fetch(from fetchingType: FetchingType = .remote,
                      in modelContext: ModelContext) async throws -> [Product] {
        try await repository.fetch(from: fetchingType, in: modelContext)
    }
    
    public func add(product: Product, in modelContext: ModelContext) async throws -> Cart {
        try await repository.add(product: product, in: modelContext)
    }
    
    public func delete(product: Product, in modelContext: ModelContext) async throws -> Cart {
        try await repository.delete(product: product, in: modelContext)
    }
}
