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
            Text(comment.commenter)
                .font(.title2)
            Text(comment.body)
                .font(.callout)
                .lineLimit(1)
        }
    }
}


struct CommentRowView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: Comment(commenter: "andrew", body: "Hello!"))
    }
}
