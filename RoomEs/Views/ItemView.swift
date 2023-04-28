//
//  EssentialListView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/24/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ItemView: View {
    @FirestoreQuery(collectionPath: "items") var items: [Item]
    @State private var sheetIsPresented = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(items.reversed()) { item in
                NavigationLink {
                    ItemDetailView(item: item)
                } label: {
                    ItemRowView(item: item)
                }
            }
            .listStyle(.plain)
            .navigationTitle("RoomEs Market")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                ItemDetailView(item: Item())
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemView()
        }
    }
}
