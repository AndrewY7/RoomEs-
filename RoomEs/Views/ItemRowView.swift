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
            HStack {
                if let listingType = ListingType(rawValue: item.listingType) {
                    if listingType == .listing {
                        Image("listing")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30, height: 30)
                            .padding()
                    } else {
                        Image("requestlarge")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30, height: 30)
                            .padding()
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:30, height: 30)
                        .padding()
                }
                
                VStack(alignment: .leading) {
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
    }
    
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: Item())
    }
}
