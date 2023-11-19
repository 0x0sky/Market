//
//  Product.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData

@Model
public final class Product: Decodable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case id, name, caption, categoryId, price, discontPrice, amount, imageUrl
        case creationDate = "creation_date"
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return DateFormatter()
    }()
    
    public let id: String
    public let name: String
    public let caption: String?
    public let categoryId: Int
    public let price: Float
    public let discontPrice: Float?
    public let amount: Float?
    public let imageUrl: String?
    public let creation_date: TimeInterval
    
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
        self.creation_date = creationDate
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
        let creation_date = try? values.decode(TimeInterval.self, forKey: .creationDate)
        self.creation_date = creation_date ?? 1698586230
    }
    
    // Equatable
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.caption == rhs.caption
        && lhs.categoryId == rhs.categoryId
        && lhs.price == rhs.price
        && lhs.discontPrice == rhs.discontPrice
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
    }
}
