import SwiftUI

struct NameInputView: View {
    @State private var userName: String = ""
    private let characterLimit = 10
    var onSave: (String) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text(Constants.Strings.nameInputViewHeading)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // TextField for Name/Alias input with character limit
            TextField(Constants.Strings.nameInputViewTextHint, text: $userName)
                .onChange(of: userName, { oldValue, newValue in
                    if newValue.count >= characterLimit {
                        self.userName = String(newValue.prefix(characterLimit))
                    }
                })
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(Constants.Dimensions.standardCornerRadius)
            
            // Character Count Display (Optional)
            Text("\(userName.count) / \(characterLimit)")
                .font(.caption)
                .foregroundColor(userName.count > characterLimit ? .red : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            // Submit Button
            Button(action: {
                saveUserName()
            }) {
                Text(Constants.Strings.continueButtonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isValidName() ? Color.blue : Color.gray)
                    .cornerRadius(20)
            }
            .disabled(!isValidName()) // Disable if name is invalid
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(Constants.Strings.appName, displayMode: .inline)
    }
    
    // Check if the name is valid (not empty and <= character limit)
    func isValidName() -> Bool {
        return !userName.isEmpty && userName.count <= characterLimit
    }
    
    // Save the user's name or alias
    func saveUserName() {
        UserDefaults.standard.set(userName, forKey: Constants.Keys.userName)
        onSave(userName)
        print("User name saved: \(userName)")
    }
}

struct NameInputView_Previews: PreviewProvider {
    static var previews: some View {
        NameInputView(onSave: { _ in })
    }
}
