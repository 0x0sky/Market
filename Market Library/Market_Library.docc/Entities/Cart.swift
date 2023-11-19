import SwiftData

@Model
public final class Cart: Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case id, products
    }
    
    @Transient public static var empty: Cart = .init(id: UUID().uuidString, products: [])
    
    public let id: String
    
    @Relationship(deleteRule: .cascade) public var products: [Product]
    
    @Transient public var totalPrice: Float {
        products.map(\.price).reduce(0, +)
    }
    @Transient public var totalDiscount: Float {
        products.compactMap(\.discontPrice).reduce(0, +)
    }
    @Transient public var delieveryPrice: Float {
        switch totalDiscount {
            case 500..<1000: return 50.0
            case 1000: return 1.0
            default: return 80.0
        }
    }
    
    public init(id: String, products: [Product]) {
        self.id = id
        self.products = products
    }
    
    // Decodable
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        products = try values.decode([Product].self, forKey: .products)
    }
    
    // Hashable
    public static func == (lhs: Cart, rhs: Cart) -> Bool {
        lhs.id == rhs.id && lhs.products.count == rhs.products.count
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(products.count)
    }
}
