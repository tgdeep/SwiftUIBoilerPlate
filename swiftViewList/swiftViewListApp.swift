//
//  swiftViewListApp.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
//

import SwiftUI
import SwiftData

@main
struct swiftViewListApp: App {
    // You don’t need to manually create a sharedModelContainer unless you want custom configuration.
    // The simpler form below handles schema setup automatically.
    
    var body: some Scene {
        WindowGroup {
            PersonListView()
        }
        // This sets up a persistent SwiftData model for the Person type
        .modelContainer(for: Person.self)
    }
}

