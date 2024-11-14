import SwiftUI

struct DailyMoodLoggingView: View {
    @State private var isDrawerOpen: Bool = false
    var userName: String = ""
    @EnvironmentObject var moodManager: MoodManager
    @State private var selectedMood: String = ""
    @State private var reflectionNote: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var showToast: Bool = false
    let moods = Constants.moods
    private let characterLimit = 50
    var onCleanSlate: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                isDrawerOpen.toggle()
                            }
                        }) {
                            Constants.Images.hamburger
                                .imageScale(.large)
                                .foregroundColor(.black)  // Ensure it's visible
                                .padding()
                        }
                        Text("\(Constants.Strings.helloText) \(userName)")
                            .font(.title3).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    ScrollView {
                        VStack(spacing: 20) {
                            Text(Constants.Strings.moodLogPageTitle)
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                                ForEach(moods, id: \.emoji) { mood in
                                    VStack {
                                        Text(mood.emoji)
                                            .font(.system(size: 50))
                                            .padding()
                                            .background(self.selectedMood == mood.title ? Constants.Colors.paleYellow : Color.gray.opacity(0.1))
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                self.selectedMood = mood.title
                                            }
                                        
                                        Text(mood.title)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                            HStack {
                                TextField(Constants.Strings.moodLogPageReflectionNoteHint, text: $reflectionNote)
                                    .focused($isTextFieldFocused)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .disabled(selectedMood.isEmpty)
                                    .frame(height: 40)
                                    .lineLimit(1)
                                
                                if !reflectionNote.isEmpty {
                                    Button(action: {
                                        reflectionNote = ""
                                    }) {
                                        Constants.Images.xMark
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                            .opacity(selectedMood.isEmpty ? 0.5 : 1)
                            
                            Text("\(reflectionNote.count) / \(characterLimit)")
                                .font(.caption)
                                .foregroundColor(reflectionNote.count > characterLimit ? .red : .gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Button(action: {
                                isTextFieldFocused = false
                                saveMoodLog()
                                showToast = true  // Show toast message
                                // Hide toast after 2 seconds
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showToast = false
                                }
                            }) {
                                Text(Constants.Strings.submitButtonText)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(getBackgroundColor())
                                    .cornerRadius(10)
                            }
                            .padding(.top, 5)
                            .disabled(selectedMood.isEmpty || reflectionNote.count > characterLimit)
                            
                            Button(action: {
                                isTextFieldFocused = false
                                resetMoodSelection()
                            }) {
                                Text(Constants.Strings.resetButtonText)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedMood.isEmpty ? Constants.Colors.softGray : Constants.Colors.softRed)
                                    .cornerRadius(10)
                            }
                            .disabled(selectedMood.isEmpty)
                            
                            Spacer()
                        }
                        .padding()
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                }
                // Drawer overlay
                if isDrawerOpen {
                    ZStack {
                        Constants.Colors.lavender.opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                isDrawerOpen = false
                            }
                        HStack{
                            DrawerView(userName:userName, onCleanSlate: onCleanSlate,isDrawerOpen: $isDrawerOpen)
                                .frame(width: UIScreen.main.bounds.width * 0.75, alignment: .leading)
                                .background(Constants.Colors.lavender)
                                .shadow(radius: 10)
                            Spacer()
                        }
                        .transition(.move(edge: .leading))
                    }
                    
                    
                }
                
                // Toast Message
                if showToast {
                    VStack {
                        Spacer()
                        Text(Constants.Strings.moodSavedMessage)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                            .transition(.move(edge: .bottom))
                            .padding()
                    }
                    .animation(.easeInOut, value: showToast)
                }
            }
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width > 100 {
                            withAnimation {
                                isDrawerOpen = true
                            }
                        } else if gesture.translation.width < -100 {
                            isDrawerOpen = false
                        }
                    }
            )
        }
    }
    
    func saveMoodLog() {
        let moodTitle = moods.first { $0.title == selectedMood }?.title ?? "Unknown Mood"
        let finalReflectionNote = reflectionNote.isEmpty ? moodTitle : reflectionNote
        moodManager.saveMood(username: userName, mood: moodTitle, note: finalReflectionNote)
        resetMoodSelection()
    }
    
    func resetMoodSelection() {
        selectedMood = ""
        reflectionNote = ""
    }
    
    func getBackgroundColor() -> Color {
        return selectedMood.isEmpty || reflectionNote.count > characterLimit ? Constants.Colors.softGray : Constants.Colors.softGreen
    }
}

struct DrawerView: View {
    var userName: String = ""
    var onCleanSlate: () -> Void
    @Binding var isDrawerOpen: Bool
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var moodManager: MoodManager
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: MoodHistoryView(userName: userName)) {
                Text(Constants.Strings.moodHistory)
                    .font(.title2).bold()
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top:5,leading: 10, bottom: 0, trailing: 0))
                    .onDisappear(perform: {
                        isDrawerOpen = false
                    })
            }
            Text(Constants.Strings.moodAnalysis)
                .font(.title2).bold()
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 0))
            Text(Constants.Strings.moodPrediction)
                .font(.title2).bold()
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 0))
            Button(action: {
                removeUserNameAndData()
            }) {
                Text(Constants.Strings.cleanSlate)
                    .font(.title2).bold()
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 0, trailing: 0))
            }
            Spacer()
        }
        .padding()
    }
    
    func removeUserNameAndData(){
        isDrawerOpen = false
        do{
            try moodManager.clearAllForUser(username: userName)
        } catch{
            print("Error while deleting records for user: \(userName)")
        }
        UserDefaults.standard.removeObject(forKey: Constants.Keys.userName)
        onCleanSlate()
        
    }
}

struct DailyMoodLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMoodLoggingView(userName: "Kartik", onCleanSlate:{})
            .environmentObject(MoodManager())
    }
}
