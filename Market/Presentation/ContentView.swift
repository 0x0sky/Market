//
//  ContentView.swift
//  Market
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftData
import SwiftUI
import Market_Library

struct ContentView: View {
    var body: some View {
        ZStack {
            ProductsListView()
                .environmentObject(ProductsListDependenciesContainer())
//            CartView()
//                .environmentObject(CartDependenciesContainer())
        }
    }
}

#Preview {
    ContentView()
}
