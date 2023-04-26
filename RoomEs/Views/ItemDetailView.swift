//
//  DetailView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/25/23.
//

import SwiftUI
import Firebase

struct ItemDetailView: View {
    @EnvironmentObject var itemVM: ItemViewModel
    @State var item: Item
    @State var postedByThisUser = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Add a New Listing")
                .padding(.bottom)
                .bold()
                .font(.largeTitle)
            
            Group {
                HStack(alignment: .top) {
                    Text("Item Name:")
                        .bold()
                    TextField("", text: $item.name)
                        .textFieldStyle(.roundedBorder)
                }
                
                HStack(alignment: .top) {
                    Text("Price:")
                        .bold()
                    TextField("", text: $item.price)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                }
                
                Text("Description:")
                    .bold()
                TextField("", text: $item.description)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                HStack(alignment: .top) {
                    Text("Location:")
                        .bold()
                    TextField("", text: $item.location)
                        .textFieldStyle(.roundedBorder)
                        .padding(.bottom)
                    
                }
                
                //TODO: Add stepper for quantity
                HStack {
                    Text("Listing/Request:")
                        .bold()
                    
                    Spacer()
                    
                    Picker("", selection: $item.listingType) {
                        ForEach(ListingType.allCases, id: \.self) { listing in
                            Text(listing.rawValue.capitalized)
                                .tag(listing.rawValue)
                        }
                    }
                }
            }
            
            AsyncImage(url:URL(string: "https://m.media-amazon.com/images/I/81PhWhriE+L._AC_UF894,1000_QL80_.jpg")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius:15)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
        }
        .disabled(!postedByThisUser)
        .font(.title2)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(item.id == nil)
        .onAppear {
            if item.reviewer == Auth.auth().currentUser?.email {
                postedByThisUser = true
            }
        }
        .navigationBarBackButtonHidden(postedByThisUser)
        .toolbar {
            if postedByThisUser {
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item())
            .environmentObject(ItemViewModel())
    }
}
