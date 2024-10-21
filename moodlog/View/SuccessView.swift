//
//  SuccessView.swift
//  moodlog
//
//  Created by Kartik Saraf on 21/10/24.
//

import SwiftUI
struct SuccessView: View {
    var dismissAction: () -> Void
    var body: some View {
        VStack {
            Text(Constants.Strings.success)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text(Constants.Strings.moodSavedMessage)
                .font(.headline)
                .padding(.top, -10)
            
            Button(action: {
                dismissAction() // Hide success view
            }) {
                Text(Constants.Strings.okButtonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Constants.Colors.softBlue)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
        }
        .padding()
    }
}
