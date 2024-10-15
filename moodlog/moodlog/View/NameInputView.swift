//
//  NameInputView.swift
//  moodlog
//
//  Created by Kartik Saraf on 15/10/24.
//


import SwiftUI

struct NameInputView: View {
    @State private var userName: String = ""
    private let characterLimit = 10

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title
                Text("What would you like to be called?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

                // TextField for Name/Alias input with character limit
                TextField("Enter your name or alias", text: Binding(
                    get: { self.userName },
                    set: { newValue in
                        if newValue.count <= characterLimit {
                            self.userName = newValue
                        }
                    }
                ))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)


                // Character Count Display (Optional)
                Text("\(userName.count) / \(characterLimit) characters")
                    .font(.caption)
                    .foregroundColor(userName.count > characterLimit ? .red : .gray)

                // Submit Button
                Button(action: {
                    saveUserName()
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isValidName() ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(!isValidName()) // Disable if name is invalid

                Spacer()
            }
            .padding()
            .navigationBarTitle("Welcome", displayMode: .inline)
        }
    }

    // Calculate the number of words in the user's name
    func characterCounter() -> Int {
        return userName.split { $0.isWhitespace }.count
    }

    // Check if the name is valid (not empty, <= word limit, and <= character limit)
    func isValidName() -> Bool {
        return !userName.isEmpty && characterCounter() <= characterLimit
    }

    // Save the user's name or alias
    func saveUserName() {
        print("User name saved: \(userName)")
        // Implement storage logic here, e.g., save to UserDefaults or CoreData
    }
}

struct NameInputView_Previews: PreviewProvider {
    static var previews: some View {
        NameInputView()
    }
}
