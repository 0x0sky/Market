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
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 8) {
                    ForEach(productsList, id: \.self) { product in
                        ZStack {
                            Button {
                                viewModel.add(product, in: modelContext)
                            } label: {
                                ProductListItemView(product: product)
                            }
                        }
                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    }
                }
                .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
                .task {
                    await productsList = viewModel.fetch(from: .db, in: modelContext)
                    await productsList = viewModel.fetch(from: .remote, in: modelContext)
                }
            }
            .navigationTitle("MARKET")
        }
    }
}

#Preview {
    ProductsListView()
}
