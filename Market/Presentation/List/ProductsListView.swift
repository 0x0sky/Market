//
//  ProductsListView.swift
//  Market
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftUI
import Market_Library

struct ProductsListView: View {
    @ProductsListDependency(\.injector.viewModel) private var viewModel
    @Environment(\.modelContext) private var modelContext
    @State var productsList: [ProductsListViewModel.Model] = []
    private let bundle = Bundle(identifier: "loghozinsky.Market.library")
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 8) {
                ForEach(productsList, id: \.self) { product in
                    ZStack {
                        Button {
                            //                            viewModel.add(product, in: modelContext)
                        } label: {
                            ZStack {
                                product.image
                                    .resizable()
                                    .clipShape(.rect(cornerRadius: 24))
                                VStack {
                                    Spacer()
                                    Text(LocalizedStringKey(product.name),
                                         tableName: "ProductsList",
                                         bundle: bundle!,
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
                            .shadow(color: .dropLight, radius: 15, x: -10, y: -10)
                        }
                    }
                    .frame(height: 150)
                }
            }
            .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            .task {
                await productsList = viewModel.fetch(from: .db, in: modelContext)
                await productsList = viewModel.fetch(from: .remote, in: modelContext)
            }
        }
    }
}

#Preview {
    ProductsListView()
}
