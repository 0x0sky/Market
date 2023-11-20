//
//  ProductListItemView.swift
//  Market
//
//  Created by Oleksander Lohozinskyi on 20.11.2023.
//

import SwiftUI
import Market_Library

struct ProductListItemView: View {
    let product: ProductsListViewModel.Model
    
    var body: some View {
        ZStack {
            product.image
                .resizable()
                .clipShape(.rect(cornerRadius: 24))
            VStack {
                Spacer()
                Text(LocalizedStringKey(product.name),
                     tableName: "ProductsList",
                     bundle: Market_Library.bundle,
                     comment: "Product name")
                .foregroundStyle(Color.black)
                .font(.system(size: 12).smallCaps())
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .padding(.horizontal)
                HStack {
                    if let formattedPrice = product.formattedPrice,
                       let formattedDiscontPrice = product.formattedDiscontPrice {
                        Text(formattedPrice)
                            .frame(alignment: .leading)
                            .foregroundStyle(.black)
                            .font(.system(size: 12).bold())
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text(formattedDiscontPrice)
                            .frame(alignment: .trailing)
                            .foregroundStyle(.red)
                            .font(.system(size: 16).bold())
                            .lineLimit(1)
                            .layoutPriority(1)
                    } else if let formattedPrice = product.formattedPrice {
                        Text(formattedPrice)
                            .frame(alignment: .center)
                            .foregroundStyle(.black)
                            .font(.system(size: 16).bold())
                            .lineLimit(1)
                    }
                }
                .padding(EdgeInsets(top: 0,
                                    leading: 8,
                                    bottom: 8,
                                    trailing: 8))
                
            }
        }
        .shadow(color: .dropShadow, radius: 15, x: 10, y: 10)
        .shadow(color: .dropLight, radius: 15, x: -10, y: -10)    }
}

#Preview {
    ProductListItemView(product: .empty)
}
