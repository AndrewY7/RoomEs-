//
//  InstructionView.swift
//  RoomEs
//
//  Created by Andrew Yang on 4/26/23.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        VStack {
            Text("About The App")
                .bold()
                .font(.title)
                .foregroundColor(.green)
            
            Text("Hello! Welcome to RoomEs Marketplace! This app was designed as a place for college students to list a posting of an item they would like to get rid of or a request for an item they may need. Since dorm or apartment essentials are necessary and coveted in living spaces, this app simplifies the process of finding items and also reduces the cost of living expenses. Many items are also thrown away at the end of school years, so exchanging or selling them is a great way to protect the environment.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.green)
            
            Image("recycle")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
                .foregroundColor(.green)
        }
    }
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView()
    }
}
