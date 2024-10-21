//
//  moodlogApp.swift
//  moodlog
//
//  Created by Kartik Saraf on 14/10/24.
//

import SwiftUI

@main
struct moodlogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
