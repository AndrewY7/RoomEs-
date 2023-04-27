//
//  EssentialViewModel.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/25/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

@MainActor
class ItemViewModel: ObservableObject {
    @Published var item = Item()

    func saveItem(item: Item) async -> Bool {
        let db = Firestore.firestore()
        if let id = item.id { //spot must already exist, so save
            do {
                try await db.collection("items").document(id).setData(item.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update the data in 'items' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                let documentRef = try await db.collection("items").addDocument(data: item.dictionary)
                self.item = item
                self.item.id = documentRef.documentID
                print("🐣 Data added successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new item in 'items' \(error.localizedDescription)")
                return false
            }
        }
    }
}
