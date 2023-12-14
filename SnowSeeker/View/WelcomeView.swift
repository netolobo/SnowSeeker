//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Neto Lobo on 13/12/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resor from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }   
    }
}

#Preview {
    WelcomeView()
}
