//
//  AddGroceryItemScreen.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/28/25.
//
//
//  Created by Jonathan Engelsma on 3/18/25.
//
// AlertToast: https://github.com/elai950/AlertToast
//

import AlertToast
import SwiftUI


struct AddGroceryItemScreen: View {
    @EnvironmentObject var groceryViewModel : GroceryViewModel
    @State var text = ""
    @State private var showToast = false
    var body: some View {
        VStack {
            HStack {
                TextField("Enter grocery item", text: $text)
                Button("Save") {
                    if text != "" {
                        groceryViewModel.items.append(GroceryItem(text: text))
                        text = ""
                        showToast.toggle()
                    }
                }
            }
            .toast(isPresenting: $showToast, duration: 1, offsetY: 100) {
                AlertToast(type: .regular, title: "Item Saved!")
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    AddGroceryItemScreen()
        .environmentObject(GroceryViewModel())
}
