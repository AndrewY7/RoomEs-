//
//  ItemRowView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/27/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ItemRowView: View {
    @State var item: Item
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
//            if let listingType = ListingType(rawValue: item.listingType) {
//                Image(systemName: listingType == .listing ? "listing" : "request")
//            } else {
//                Image(systemName: "photo")
//            }
            Text(item.name)
                .font(.headline)
            Text(item.description)
                .font(.subheadline)
                .padding(.bottom)
            Text("Posted by: \(item.poster)")
                .font(.subheadline)
            Text("Date Posted: \(Self.dateFormatter.string(from: item.postedOn))")
                .font(.subheadline)
        }
    }
    
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item())
    }
}
