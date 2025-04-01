//
//  FBHelper.swift
//  GroceryListApp
//
//  Created by Jonathan Engelsma on 3/31/25.
//

import FirebaseFirestore
import Foundation

var db = Firestore.firestore()
var listener : ListenerRegistration? = nil

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

func deleteItem(item: GroceryItem) async {
    do {
        try await db.collection("groceryList").document(item.id.uuidString).delete()
        print("Document successfully removed!")

    } catch {
        print("Error removing document: (error)")
    }
}

func listenForItemUpdates(vm: GroceryViewModel) {
    listener = db.collection("groceryList")
        .addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: (error!)")
                return
            }
            // parse the documents retrieved from snapshot here!
            var parsedItems = [GroceryItem]()
            for document in documents {
                let id = document.documentID
                let data = document.data()
                let text = data["text"] as? String ?? ""
                let done = data["done"] as? Bool ?? false
                let item = GroceryItem(id: UUID(uuidString: id) ?? UUID(), done: done, text: text )
                parsedItems.append(item)
            }
            print("read (parsedItems.count) items.")

            Task { @MainActor in
                vm.items = parsedItems  // update must be done on the @MainActor
            }

        }

}

func stopListeningForItemUpdates() {
    if let l = listener {
        l.remove()
    }
}
