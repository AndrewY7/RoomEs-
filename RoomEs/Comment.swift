//
//  Comment.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/26/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    @DocumentID var id: String?
    var commenter = ""
    var body = ""
    var postedOn = Date()
    
    var dictionary: [String: Any] {
        return ["commenter": Auth.auth().currentUser?.email ?? "", "body": body, "postedOn": Timestamp(date: Date())]
    }
}
