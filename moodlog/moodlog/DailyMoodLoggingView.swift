import SwiftUI

struct DailyMoodLoggingView: View {
    @State private var selectedMood: String = ""
    @State private var reflectionNote: String = ""
    
    // Define the moods with titles
    let moods: [(emoji: String, title: String)] = [
        ("😊", "Happy"),
        ("😔", "Sad"),
        ("😡", "Angry"),
        ("😰", "Anxious"),
        ("😐", "Neutral"),
        ("😃", "Excited")
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title
                Text("How are you feeling today?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding()

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
                                .foregroundColor(.black)
                        }
                    }
                }

                // Reflection Text Field with "X" clear icon, disabled if no mood is selected
                HStack {
                    TextField("Why do you feel this way?", text: $reflectionNote)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
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

                // Submit Button
                Button(action: {
                    saveMoodLog()
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                .disabled(selectedMood.isEmpty) // Disabled if no mood is selected

                // Reset Button (Disabled if no mood selected)
                Button(action: {
                    resetMoodSelection()
                }) {
                    Text("Reset")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedMood.isEmpty ? Color.gray : Color.red) // Gray if disabled
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                .disabled(selectedMood.isEmpty) // Disabled if no mood is selected

                Spacer()
            }
            .padding()
            .navigationBarTitle("Mood Log", displayMode: .inline)
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
        DailyMoodLoggingView()
    }
}
