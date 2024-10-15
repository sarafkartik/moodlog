import SwiftUI

struct DailyMoodLoggingView: View {
    var userName: String = ""
    @State private var selectedMood: String = ""
    @State private var reflectionNote: String = ""
    
    // Define the moods with titles
    let moods = Constants.moods
    private let characterLimit = Constants.Thresholds.reflectionNoteMaximumLemgth
    
    var body: some View {
        VStack(spacing: Constants.Dimensions.standardSpacing) {
            // Title
            Text(Constants.Strings.moodLogPageTitle)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 10) // Adjust top padding to reduce gap
                .padding(.bottom, 10) // Adjust bottom padding to reduce gap
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Mood Icons Grid with titles below
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(moods, id: \.emoji) { mood in
                    VStack {
                        Text(mood.emoji)
                            .font(.system(size: 50))
                            .padding()
                            .background(self.selectedMood == mood.title ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                            .cornerRadius(Constants.Dimensions.standardCornerRadius)
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
            
            // Reflection Text Field with "X" clear icon, disabled if no mood is selected
            HStack {
                TextField(Constants.Strings.moodLogPageReflectionNoteHint, text: Binding(
                    get: { reflectionNote },
                    set: {
                        let charcterCount = $0.count
                        if charcterCount <= characterLimit {
                            reflectionNote = $0
                        }
                    }
                ))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(Constants.Dimensions.standardCornerRadius)
                .disabled(selectedMood.isEmpty) // Disabled if no mood is selected
                .frame(height: 40)
                .lineLimit(1) // Limit reflection note to one line
                
                // X Icon to clear reflection note, only visible if reflection note is not empty
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
            .opacity(selectedMood.isEmpty ? 0.5 : 1) // Visual cue for disabled text field
            
            // Word Count Display
            Text("\(reflectionNote.split { $0.isWhitespace }.count) / \(characterLimit)")
                .font(.caption)
                .foregroundColor(reflectionNote.split { $0.isWhitespace }.count > characterLimit ? .red : .gray)
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
                    .cornerRadius(Constants.Dimensions.standardCornerRadius)
            }
            .padding(.top, 5)
            .disabled(selectedMood.isEmpty) // Disabled if no mood is selected
            
            // Reset Button (Disabled if no mood selected)
            Button(action: {
                resetMoodSelection()
            }) {
                Text(Constants.Strings.resetButtonText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedMood.isEmpty ? Color.gray : Color.red) // Gray if disabled
                    .cornerRadius(Constants.Dimensions.standardCornerRadius)
            }
            .disabled(selectedMood.isEmpty) // Disabled if no mood is selected
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline) // Hide default title
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(Constants.Strings.helloText) \(userName)")  // Custom title
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading) // Align to left
            }
        }
    }
    
    
    // Function to handle mood logging
    func saveMoodLog() {
        // Check if reflection note is empty and assign mood title if so
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
