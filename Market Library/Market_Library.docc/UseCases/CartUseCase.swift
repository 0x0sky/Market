import SwiftData

public struct CartUseCase {
    public let repository: CartRepository
    
    public func fetch(in modelContext: ModelContext) async throws -> Cart {
        try await repository.fetch(in: modelContext)
    }
}
