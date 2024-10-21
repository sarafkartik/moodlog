import SwiftUI

struct DailyMoodLoggingView: View {
    var userName: String = ""
    @State private var selectedMood: String = ""
    @State private var reflectionNote: String = ""
    
    // Define the moods with titles
    let moods = Constants.moods
    private let characterLimit = 100
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(Constants.Strings.helloText) \(userName)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            // Title
            Text(Constants.Strings.moodLogPageTitle)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 10)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Mood Icons Grid with titles below
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(moods, id: \.emoji) { mood in
                    VStack {
                        Text(mood.emoji)
                            .font(.system(size: 50))
                            .padding()
                            .background(self.selectedMood == mood.title ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .onTapGesture {
                                self.selectedMood = mood.title
                            }
                        
                        // Mood Title
                        Text(mood.title)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // Reflection Text Field with "X" clear icon
            HStack {
                TextField(Constants.Strings.moodLogPageReflectionNoteHint, text: Binding(
                    get: { reflectionNote },
                    set: {
                        if $0.count <= characterLimit {
                            reflectionNote = $0
                        }
                    }
                ))
                .onChange(of: reflectionNote, { oldValue, newValue in
                    if newValue.count >= characterLimit {
                        self.reflectionNote = String(newValue.prefix(characterLimit))
                    }
                })
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .disabled(selectedMood.isEmpty)
                .frame(height: 40)
                .lineLimit(1)
                
                // X Icon to clear reflection note
                if !reflectionNote.isEmpty {
                    Button(action: {
                        reflectionNote = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                }
            }
            .opacity(selectedMood.isEmpty ? 0.5 : 1)
            
            // Word Count Display
            Text("\(reflectionNote.split { $0.isWhitespace }.count) / \(characterLimit)")
                .font(.caption)
                .foregroundColor(reflectionNote.count > characterLimit ? .red : .gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            // Submit Button
            Button(action: {
                saveMoodLog()
            }) {
                Text(Constants.Strings.submitButtonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 5)
            .disabled(selectedMood.isEmpty)
            
            // Reset Button
            Button(action: {
                resetMoodSelection()
            }) {
                Text(Constants.Strings.resetButtonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedMood.isEmpty ? Color.gray : Color.red)
                    .cornerRadius(10)
            }
            .disabled(selectedMood.isEmpty)
            
            Spacer()
        }
        .padding()
    }
    
    // Function to handle mood logging
    func saveMoodLog() {
        let moodTitle = moods.first { $0.title == selectedMood }?.title ?? "Unknown Mood"
        let finalReflectionNote = reflectionNote.isEmpty ? moodTitle : reflectionNote
        
        print("Mood: \(selectedMood), Reflection: \(finalReflectionNote)")
        // Add CoreData saving logic here later
    }
    
    // Function to reset the mood selection and reflection note
    func resetMoodSelection() {
        selectedMood = ""
        reflectionNote = ""
    }
}

struct DailyMoodLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMoodLoggingView(userName: "Kartik")
    }
}
