//
//  CartView.swift
//  Market
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData
import SwiftUI
import Market_Library

struct CartView: View {
    @CartDependency(\.injector.viewModel) private var viewModel: CartViewModel
    @Environment(\.modelContext) private var modelContext
    @State var cart: CartViewModel.Model = .empty
    
    var body: some View {
        Text($cart.id)
            .task {
                await cart = viewModel.fetch(in: modelContext)
                dump(cart)
//                await viewModel.save(cart, in: modelContext)
            }
    }
}

#Preview {
    CartView()
}
