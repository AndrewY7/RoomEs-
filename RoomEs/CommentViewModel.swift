//
//  CommentViewModel.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/26/23.
//

import Foundation
import FirebaseFirestore

class CommentViewModel: ObservableObject {
    @Published var comment = Comment()
    
    func saveComment(item: Item, comment: Comment) async -> Bool {
        let db = Firestore.firestore()
        
        guard let itemID = item.id else {
            print("😡 ERROR: item.id = nil")
            return false
        }
        
        let collectionString = "items/\(itemID)/comments"
        
        if let id = comment.id {
            do {
                try await db.collection(collectionString).document(id).setData(comment.dictionary)
                print("😎 Data updated successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not update the data in 'comments' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                _ = try await db.collection(collectionString).addDocument(data: comment.dictionary)
                print("🐣 Data added successfully!")
                return true
            } catch {
                print("😡 ERROR: Could not create a new comment in 'comments' \(error.localizedDescription)")
                return false
            }
        }
    }
    
    func deleteComment(item: Item, comment: Comment) async -> Bool {
        let db = Firestore.firestore()
        guard let itemID = item.id, let commentID = comment.id else {
            print("😡 ERROR: item.id = \(item.id ?? "nil"), comment.id = \(comment.id ?? "nil"). This should not have happened.")
            return false
        }
        do {
            let _ = try await db.collection("items").document(itemID).collection("comments").document(commentID).delete()
            print("Document successfully deleted")
            return true
        } catch {
            print("😡 ERROR: removing document \(error.localizedDescription)")
            return false
        }
    }
}
