//
//  GroceryListViewModel.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/28/25.
//

import Foundation

struct GroceryItem: Identifiable {
    var id = UUID()
    var done: Bool = false
    var text: String
}

class GroceryViewModel : ObservableObject {
    @Published var items: [GroceryItem] = []
    
    func toggleDone(for id: UUID) {
        if let index = items.firstIndex(where: {$0.id == id}) {
            self.items[index].done.toggle()
        }
    }
    
    func delete(for id: UUID) {
        items.removeAll { item in
            item.id == id
        }
    }
}
