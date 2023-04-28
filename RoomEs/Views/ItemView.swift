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
    @State private var searchText = ""
    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredItems) { item in
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
            .searchable(text: $searchText, prompt: "Search Items")
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
