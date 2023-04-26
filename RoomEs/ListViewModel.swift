//
//  ListViewModel.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/26/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

@MainActor
class ListViewModel: ObservableObject {
    @Published var list = List()

    func saveList(list: List) async -> String? {
        let db = Firestore.firestore()
        if let id = list.id { // place must already exist, so save
            do {
                try await db.collection("lists").document(id).setData(list.dictionary)
                print("😎 Data updated successfully!")
                return list.id
            } catch {
                print("😡 ERROR: Could not update data in 'places' \(error.localizedDescription)")
                return nil
            }
        } else { // no id? Then this must be a new student to add
            do {
                let docRef = try await db.collection("lists").addDocument(data: list.dictionary)
                print("🐣 Data added successfully!")
                return docRef.documentID
            } catch {
                print("😡 ERROR: Could not create a new place in 'places' \(error.localizedDescription)")
                return nil
            }
        }
    }
    
}
