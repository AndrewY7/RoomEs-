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
    @State var item: Item
    @State var posterName: String = ""
    
    var body: some View {
        VStack {
            Text(posterName)
                .font(.largeTitle)
                .bold()
        }
        .onAppear {
            let db = Firestore.firestore()
            db.collection("posters").whereField("email", isEqualTo: item.poster).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let userData = querySnapshot?.documents.first?.data()
                    let posterName = userData?["name"] as? String ?? ""
                    self.posterName = posterName
                }
            }
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(item: Item())
            .environmentObject(ItemViewModel())
    }
}
