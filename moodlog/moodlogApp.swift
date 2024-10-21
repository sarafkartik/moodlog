//
//  moodlogApp.swift
//  moodlog
//
//  Created by Kartik Saraf on 14/10/24.
//

import SwiftUI

@main
struct MoodLogApp: App {
    @State private var isActive = false

    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
            } else {
                SplashScreenView()
                    .onAppear {
                        // Simulate a delay for the splash screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
            }
        }
    }
}

