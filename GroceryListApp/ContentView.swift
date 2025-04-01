//
//  ContentView.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/28/25.
//

import SwiftUI

enum FilterMode : String {
    case All = "All"
    case Done = "Done"
    case NotDone = "Not Done"
}

struct ContentView: View {
    @EnvironmentObject var groceryViewModel : GroceryViewModel
    @State var mode : FilterMode = .All
    var visibleItems : [GroceryItem] {
        switch mode {
        case .All:
            return groceryViewModel.items
        case .Done:
            return groceryViewModel.items.filter({ $0.done })
        case .NotDone:
            return groceryViewModel.items.filter({!$0.done})
        }
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(visibleItems) {item in
                    HStack {
                        
                        Button {
                            Task {
                                await updateItem(item: GroceryItem(id: item.id, done: !item.done, text: item.text))
                            }
                            //groceryViewModel.toggleDone(for: item.id)
                        } label: {
                            Image(systemName: item.done ? "checkmark.square" : "square")
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text(item.text)
                    }
                }
                .onDelete(perform: delete)
            }
            .onAppear() {
                print("listening for firebase updates...")
                listenForItemUpdates(vm: groceryViewModel)
            }
            .onDisappear() {
                print("no longer listening for firebase updates...")
                stopListeningForItemUpdates()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(mode.rawValue) {
                        switch mode {
                        case .All:
                            mode = .NotDone
                        case .Done:
                            mode = .All
                        case .NotDone:
                            mode = .Done
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Grocery List")
                        .font(.largeTitle)
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddGroceryItemScreen()) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        let item = visibleItems[offsets.first ?? 0]
        //groceryViewModel.delete(for: item.id)
        Task {
            await deleteItem(item: item)
        }

    }
}

#Preview {
    ContentView()
        .environmentObject(GroceryViewModel())
}
