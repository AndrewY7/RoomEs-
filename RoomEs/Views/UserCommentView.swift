//
//  UserCommentView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/27/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

struct UserCommentView: View {
    @FirestoreQuery(collectionPath: "items") var comments: [Comment]
    @State var comment: Comment
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("My Comments:")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .overlay(
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 16) {
                                ForEach(userComments()) { comment in
                                    VStack(alignment: .leading) {
                                        Text(comment.commenter)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        Text(comment.body)
                                            .font(.body)
                                            .padding(.bottom)
                                    }
                                }
                            }
                            .padding()
                        }
                    )
                    .padding()
            }
        }
    }
    
    func userComments() -> [Comment] {
        guard let userEmail = Auth.auth().currentUser?.email else {
            return []
        }
        
        return comments.filter { $0.commenter == userEmail }
    }
}

struct UserCommentView_Previews: PreviewProvider {
    static var previews: some View {
        UserCommentView(comment: Comment())
    }
}

