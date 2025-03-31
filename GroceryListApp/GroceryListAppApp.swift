//
//  GroceryListAppApp.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/28/25.
//

import SwiftUI

@main
struct GroceryListAppApp: App {
    @StateObject var groceryViewModel = GroceryViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(groceryViewModel)
        }
    }
}
