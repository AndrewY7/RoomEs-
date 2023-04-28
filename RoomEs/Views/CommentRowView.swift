//
//  CommentRowView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/27/23.
//

import SwiftUI

struct CommentRowView: View {
    @State var comment: Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "text.bubble")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("Comment by: \(comment.commenter)")
                    .font(.title2)
            }
        }
    }
}


struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: Comment(commenter: "andrew", body: "Hello!"))
    }
}
