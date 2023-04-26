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
    @EnvironmentObject var itemVM: ItemViewModel
    @FirestoreQuery(collectionPath: "items") var items: [Item]
    @State private var sheetIsPresented = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink {
                    ItemDetailView(item: item)
                } label: {
                    Text(item.name)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("RoomEs Marketplace")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                            print("😡 ERROR: Could not sign out!")
                        }
                    }
                }
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
                .environmentObject(ItemViewModel())
        }
    }
}
