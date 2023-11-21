//
//  ProductsListViewModel.swift
//  Market Library
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData
import SwiftUI

public struct ProductsListViewModel {
    public struct Model: Sendable, Identifiable, Hashable {
        public static var empty: Self {
            ProductsListViewModel.Model(id: "CANNOT_BE_USED",
                                        name: "PLACEHOLDER",
                                        caption: nil,
                                        category: "PLACEHOLDER",
                                        price: 0.0,
                                        discontPrice: nil,
                                        amount: nil,
                                        imageUrl: nil,
                                        creationDate: .now)
        }
        
        public static func == (lhs: ProductsListViewModel.Model, rhs: ProductsListViewModel.Model) -> Bool {
            lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.caption == rhs.caption
            && lhs.category == rhs.category
            && lhs.price == rhs.price
            && lhs.discontPrice == rhs.discontPrice
            && lhs.imageUrl == rhs.imageUrl
            && lhs.creationDate == rhs.creationDate
        }
        
        public let id: String
        public let name: String
        public let caption: String?
        public let category: String
        
        fileprivate let price: Float
        fileprivate let discontPrice: Float?
        fileprivate let amount: Float?
        fileprivate let imageUrl: String?
        fileprivate let creationDate: Date
        
        public var formattedPrice: AttributedString? {
            let priceNumber = NSNumber(value: price)
            guard let formattedPrice = ProductsListViewModel.numberFormatter.string(from: priceNumber) else {
                return nil
            }
            
            let mutable = NSMutableAttributedString(string: formattedPrice)
            if discontPrice != nil {
                mutable.addAttribute(.strikethroughStyle,
                                     value: 1,
                                     range: NSRange(location: 0, length: mutable.length - 1)
                )
            }
            let attributedString = AttributedString(mutable)
            
            return attributedString
        }
        
        public var formattedDiscontPrice: String? {
            guard let discontPrice else {
                return nil
            }
            
            let priceNumber = NSNumber(value: discontPrice)
            let formattedPrice = ProductsListViewModel.numberFormatter.string(from: priceNumber)
            
            return formattedPrice
        }
        
        public var image: Image {
            if let imageUrl {
                return Image(imageUrl, bundle: Bundle(identifier: "com.loghozinsky.market.library"))
            }
            
            return Image(systemName: "photo.fill")
        }
        
        public var isAvaiable: Bool {
            if let amount {
                return amount > 0
            }
            
            return false
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(caption)
            hasher.combine(category)
            hasher.combine(price)
            hasher.combine(discontPrice)
            hasher.combine(imageUrl)
        }
    }
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.locale = .init(Locale(languageCode: "uk-UA"))
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    private var _productsUseCase: ProductsListUseCase
    
    public init(useCase: ProductsListUseCase) {
        self._productsUseCase = useCase
    }
    
    public static func model(from entity: Product) -> Model {
        Model(id: entity.id,
              name: entity.name,
              caption: entity.caption,
              category: "",//product.categoryId.description,
              price: entity.price,
              discontPrice: entity.discontPrice,
              amount: entity.amount,
              imageUrl: entity.imageUrl,
              creationDate: Date(timeIntervalSince1970: entity.creation_date))
    }
    
    public static func entity(from model: Model) -> Product {
        Product(id: model.id,
                name: model.name,
                caption: model.caption,
                categoryId: Int(model.category) ?? -1,
                price: model.price,
                discontPrice: model.discontPrice,
                amount: model.amount,
                imageUrl: model.imageUrl,
                creationDate: model.creationDate.timeIntervalSince1970)
    }
    
    public func fetch(from fetchingType: FetchingType, in modelContext: ModelContext) async -> [Model] {
        do {
            return try await _productsUseCase.fetch(from: fetchingType, in: modelContext).map { Self.model(from: $0) }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    public func add(_ model: Model, in modelContext: ModelContext) {
        Task.detached(priority: .userInitiated) {
            do {
                return try await _productsUseCase.add(product: Self.entity(from: model), in: modelContext)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
    public func delete(_ model: Model, in modelContext: ModelContext) {
        Task.detached(priority: .userInitiated) {
            do {
                return try await _productsUseCase.delete(product: Self.entity(from: model), in: modelContext)
            } catch {
                fatalError()
            }
        }
    }
}
