import SwiftUI

struct DailyMoodLoggingView: View {
    var userName: String = ""
    @State private var selectedMood: String = ""
    @State private var reflectionNote: String = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var showSuccessView: Bool = false
    let moods = Constants.moods
    private let characterLimit = 50
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("\(Constants.Strings.helloText) \(userName)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
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
                                    .background(self.selectedMood == mood.title ? Constants.Colors.palePink : Color.gray.opacity(0.1))
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
                        showSuccessView = true // Show success view
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
        .sheet(isPresented: $showSuccessView) { // Present success view
            SuccessView {
                showSuccessView = false
            }
        }
    }
    
    func saveMoodLog() {
        let moodTitle = moods.first { $0.title == selectedMood }?.title ?? "Unknown Mood"
        let finalReflectionNote = reflectionNote.isEmpty ? moodTitle : reflectionNote
        print("Mood: \(selectedMood), Reflection: \(finalReflectionNote)")
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

struct DailyMoodLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMoodLoggingView(userName: "Kartik")
    }
}
