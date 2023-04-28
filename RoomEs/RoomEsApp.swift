//
//  RoomEsApp.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/24/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct RoomEsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var itemVM = ItemViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(itemVM)
        }
    }
}
