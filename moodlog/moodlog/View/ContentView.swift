//
//  ContentView.swift
//  moodlog
//
//  Created by Kartik Saraf on 14/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var userName: String? = nil
    
    var body: some View {
        NavigationView {
            if userName != nil {
                DailyMoodLoggingView(userName: userName ?? "") // If the name is saved, show MoodLogView
            } else {
                NameInputView{name in
                    userName = name
                } // If no name is saved, show NameInputView
            }
        }
        .onAppear() {
            // Check if the user name exists in UserDefaults
            userName = UserDefaults.standard.string(forKey: Constants.Keys.userName)
        }
    }
}
