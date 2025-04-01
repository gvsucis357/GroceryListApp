//
//  FBHelper.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/31/25.
//

import FirebaseFirestore
import Foundation

var db = Firestore.firestore()

func addItem(item: GroceryItem) async {
    do {
        try await db.collection("groceryList").document(item.id.uuidString).setData([
            "text": item.text,
            "done": item.done
        ])
        print("Document sucessfully written")
    } catch {
        print("Error adding item to Firebase!: (error)")
    }
}

func updateItem(item: GroceryItem) async {
    let itemRef = db.collection("groceryList").document(item.id.uuidString)
    do {
        try await itemRef.updateData([
            "done" : item.done
        ])
        print("Document successfully updated")
    } catch {
        print("Error updating document: (error)")
    }

}
