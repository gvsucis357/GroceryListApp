//
//  GroceryListAppApp.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/28/25.
//

import SwiftUI

import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("ApplicationDelegate didFinishLaunchingWithOptions.")
        FirebaseApp.configure()
        return true
    }
}


@main
struct GroceryListAppApp: App {
    @StateObject var groceryViewModel = GroceryViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(groceryViewModel)
        }
    }
}
