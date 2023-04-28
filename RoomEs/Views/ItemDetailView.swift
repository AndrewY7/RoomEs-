//
//  DetailView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/25/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore
import Combine

struct ItemDetailView: View {
    @EnvironmentObject var itemVM: ItemViewModel
    @FirestoreQuery(collectionPath: "items") var comments: [Comment]
    @State var item: Item
    @State private var showCommentViewSheet = false
    @State private var showingAsSheet = false
    @State private var showSaveAlert = false
    @Environment(\.dismiss) private var dismiss
    var previewRunning = false
    
    var body: some View {
        VStack(alignment: .leading) {
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
                        .keyboardType(.numberPad)
                        .onReceive(Just(item.price)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                item.price = filtered
                            }
                        }
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
            
            HStack {
                Text("Comments")
                    .font(.title2)
                    .bold()
                Spacer()
                Button("+") {
                    if item.id == nil {
                        showSaveAlert.toggle()
                    } else {
                        showCommentViewSheet.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                .bold()
                .tint(.blue)
            }
            
            List {
                Section {
                    ForEach(comments) { comment in
                        NavigationLink {
                            CommentView(item: item, comment: Comment())
                        } label : {
                            Text("\(comment.body)")
                        }
                    }
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .font(.title2)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(showingAsSheet)
        .onAppear {
            if !previewRunning && item.id != nil {
                $comments.path = "item/\(item.id ?? "")/comments"
            } else {
                showingAsSheet = true
            }
        }
        .toolbar {
            if showingAsSheet {
                if item.id == nil && showingAsSheet {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            Task {
                                let success = await itemVM.saveItem(item: item)
                                if success {
                                    dismiss()
                                } else {
                                    print("😡 DANG: Error saving item!")
                                }
                            }
                            dismiss()
                        }
                    }
                }
            } else if showingAsSheet && item.id != nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showCommentViewSheet) {
            NavigationStack {
                CommentView(item: item, comment: Comment())
            }
        }
        .alert("Cannot Comment Unless It is Saved", isPresented: $showSaveAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Save", role: .none) {
                Task {
                    let success = await itemVM.saveItem(item: item)
                    item = itemVM.item
                    if success {
                        $comments.path = "items/\(item.id ?? "")/comments"
                        showCommentViewSheet.toggle()
                    } else {
                        print("😡 Dang! Error saving spot!")
                    }
                }
            }
        } message: {
            Text("Would you like to save this alert first so that you can enter a comment?")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item(), previewRunning: true)
            .environmentObject(ItemViewModel())
    }
}
