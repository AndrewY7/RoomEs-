//
//  MainView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/25/23.
//

import SwiftUI
    
struct HomeView: View {
    var body: some View {
        VStack {
            TabView {
                ItemView()
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
            
                InstructionView()
                    .tabItem() {
                        Image(systemName: "questionmark.circle.fill")
                        Text("About")
                    }
                
                UserCommentView(comment: Comment())
                    .tabItem() {
                        Image(systemName: "bubble.right.circle.fill")
                        Text("My Comments")
                    }
                
                ProfileDetailView(item: Item())
                    .tabItem() {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
            }
            .onAppear() {
                UITabBar.appearance().backgroundColor = .systemGray6
            }
            .tint(.blue)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
