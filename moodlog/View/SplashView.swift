//
//  SplashView.swift
//  moodlog
//
//  Created by Kartik Saraf on 21/10/24.
//
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.white // Background color
            
            VStack {
                Text(Constants.Strings.appName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
        }
    }
}
