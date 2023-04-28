//
//  CommentView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/26/23.
//

import SwiftUI
import Firebase

struct CommentView: View {
    @StateObject var commentVM = CommentViewModel()
    @State var item: Item
    @State var comment: Comment
    @State var commenterString = ""
    @State var postedByThisUser = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack (alignment: .leading){
                Text(item.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(self.commenterString)
                .font(postedByThisUser ? .title2 : .subheadline)
                .bold(postedByThisUser)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal)
  
            VStack (alignment: .leading) {
                Text("Comment:")
                    .bold()
                
                TextField("comment", text: $comment.body, axis: .vertical)
                    .padding(.horizontal, 6)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
            }
            .disabled(!postedByThisUser)
            .padding(.horizontal)
            .font(.title2)
            
            Spacer()
        }
        .onAppear {
            if comment.commenter == Auth.auth().currentUser?.email {
                postedByThisUser = true
            } else {
                let commentPostedOn = comment.postedOn.formatted(date: .numeric, time: .omitted)
                commenterString = "by: \(comment.commenter) on: \(commentPostedOn)"
            }
        }
        .navigationBarBackButtonHidden(postedByThisUser)
        .toolbar {
            if postedByThisUser {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await commentVM.saveComment(item:item, comment: comment)
                            if success {
                                dismiss()
                            } else {
                                print("😡 ERROR saving data in CommentView")
                            }
                        }
                    }
                }
                
                if comment.id != nil {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        
                        Button {
                            Task {
                                let success = await commentVM.deleteComment(item: item, comment: comment)
                                if success {
                                    dismiss()
                                }
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(item: Item(name: "Bike", price: "75"), comment: Comment())
    }
}
