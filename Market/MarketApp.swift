//
//  MarketApp.swift
//  Market
//
//  Created by Oleksander Lohozinskyi on 18.11.2023.
//

import SwiftUI
import SwiftData
import Market_Library

@main
struct Mobile_MarketApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Product.self, Cart.self
        ], version: .init(1, 0, 0))
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
