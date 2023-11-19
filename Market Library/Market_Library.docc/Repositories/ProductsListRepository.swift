import SwiftData

public enum FetchingType {
    case db, remote
}

public struct ProductsListRepository {
    let dataBaseDataSource: ProductsListDataBaseDataSource
    let remoteDataSource: ProductsListRemoteDataSource
    
    func fetch(from fetchingType: FetchingType, in modelContext: ModelContext) async throws -> [Product] {
        switch fetchingType {
            case .db: return try await dataBaseDataSource.fetch(in: modelContext)
            case .remote:
                try modelContext.deleteAll(model: Product.self)
                let models = try await remoteDataSource.fetch(in: modelContext)
                models.forEach {
                    modelContext.insert($0)
                }
                try modelContext.save()
                return models
        }
    }
    
    func add(product: Product, in modelContext: ModelContext) async throws -> Cart {
        try await dataBaseDataSource.add(product: product, in: modelContext)
    }
    
    func delete(product: Product, in modelContext: ModelContext) async throws -> Cart {
        try await dataBaseDataSource.delete(product: product, in: modelContext)
    }
    
}
