//
//  ProfileDetailView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/27/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

struct ProfileDetailView: View {
    @EnvironmentObject var itemVM: ItemViewModel
    @FirestoreQuery(collectionPath: "items") var items: [Item]
    @FirestoreQuery(collectionPath: "items") var comments: [Comment]
    @Environment(\.dismiss) private var dismiss
    let item: Item
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.leading)
                    Text("Profile")
                        .bold()
                        .font(.largeTitle)
                        .padding()
                }
                
                Text("User:")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                Text(Auth.auth().currentUser?.email ?? "")
                    .font(.title)
                    .padding()
                
                Text("My Listings:")
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 5)
                    .overlay(
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 16) {
                                ForEach(userPosts()) { item in
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Text(item.description)
                                            .font(.body)
                                            .padding(.bottom)
                                    }
                                }
                            }
                            .padding()
                        }
                    )
                    .padding()
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
                    }
            }
            
            Spacer()
        }
    }
    
    func userPosts() -> [Item] {
        guard let userEmail = Auth.auth().currentUser?.email else {
            return []
        }
        return items.filter { $0.poster == userEmail }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(item: Item())
            .environmentObject(ItemViewModel())
    }
}
