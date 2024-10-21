import SwiftUI
import CoreData

struct ContentView: View {
    @State private var userName: String? = nil
    
    var body: some View {
        NavigationView {
            Group {
                if let name = userName {
                    DailyMoodLoggingView(userName: name) // Use optional binding here
                } else {
                    NameInputView { name in
                        userName = name
                    } // Show NameInputView if no name is saved
                }
            }
            .navigationBarHidden(true) // Optionally hide the navigation bar if not needed
        }
        .onAppear {
            // Check if the user name exists in UserDefaults
            userName = UserDefaults.standard.string(forKey: Constants.Keys.userName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
