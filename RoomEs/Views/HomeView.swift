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
            
                ProfileView()
                    .tabItem() {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
            }
            .toolbarBackground(.black, for: .tabBar)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
