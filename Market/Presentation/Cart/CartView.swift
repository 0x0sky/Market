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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CartView()
}
