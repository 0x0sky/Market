import SwiftData

public enum SchemaV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version = .init(6, 0, 0)
    
    public static var models: [any PersistentModel.Type] {
        [Self.Product.self, Self.Cart.self]
    }
    
    @Model
    public final class Product: Decodable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case id, name, caption, categoryId, price, discontPrice, amount, imageUrl
            case creationDate = "creation_date"
        }
        
        public let id: String
        public let name: String
        public let caption: String?
        public let categoryId: Int
        public let price: Float
        public let discontPrice: Float?
        public let amount: Float?
        public let imageUrl: String?
        @Attribute(originalName: CodingKeys.creationDate.stringValue) public let creationDate: TimeInterval
        
        public init(id: String,
                    name: String,
                    caption: String?,
                    categoryId: Int,
                    price: Float,
                    discontPrice: Float?,
                    amount: Float?,
                    imageUrl: String?,
                    creationDate: TimeInterval) {
            self.id = id
            self.name = name
            self.caption = caption
            self.categoryId = categoryId
            self.price = price
            self.discontPrice = discontPrice
            self.amount = amount
            self.imageUrl = imageUrl
            self.creationDate = creationDate
        }
        
        // Decodable
        public required init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(String.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            caption = try? values.decode(String.self, forKey: .caption)
            categoryId = try values.decode(Int.self, forKey: .categoryId)
            price = try values.decode(Float.self, forKey: .price)
            discontPrice = try? values.decode(Float.self, forKey: .discontPrice)
            amount = try? values.decode(Float.self, forKey: .amount)
            imageUrl = try? values.decode(String.self, forKey: .imageUrl)
            creationDate = (try? values.decode(TimeInterval.self, forKey: .creationDate)) ?? 1698586230
        }
        
        // Equatable
        public static func == (lhs: Product, rhs: Product) -> Bool {
            lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.caption == rhs.caption
            && lhs.categoryId == rhs.categoryId
            && lhs.price == rhs.price
            && lhs.discontPrice == rhs.discontPrice
            && lhs.creationDate == rhs.creationDate
        }
        
        // Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(caption)
            hasher.combine(categoryId)
            hasher.combine(price)
            hasher.combine(discontPrice)
            hasher.combine(imageUrl)
            hasher.combine(creationDate)
        }
    }
    
    @Model
    public final class Cart: Decodable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case id, products
        }
        
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
}


public enum MigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] {
        [SchemaV1.self]
    }
    
    public static var stages: [MigrationStage] {
        []
    }

//    public static let migrateV1toV2 = MigrationStage.custom(
//        fromVersion: SchemaV1.self,
//        toVersion: SchemaV2.self,
//        willMigrate: { context in
//            context.deleteAll(model: Product.self)
//        }, didMigrate: nil
//    )
}
