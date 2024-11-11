//
//  MoodManager.swift
//  moodlog
//
//  Created by Kartik Saraf on 21/10/24.
//


import Foundation
import CoreData

class MoodManager: ObservableObject {
    private let context = PersistenceController.shared.container.viewContext
    
    // Save or update the mood entry
    func saveMood(username: String, mood: String, note: String) {
        let today = Calendar.current.startOfDay(for: Date())
        
        // Check if an entry exists for today
        if let existingEntry = fetchMoodEntry(for: username, on: today) {
            // Update the existing entry
            existingEntry.currentMood = mood
            existingEntry.reflectionNote = note
        } else {
            // Create a new mood entry
            let newEntry = MoodEntry(context: context)
            newEntry.userName = username
            newEntry.logDate = today
            newEntry.currentMood = mood
            newEntry.reflectionNote = note
        }
        
        // Save context
        do {
            try context.save()
            self.viewRecords()
        } catch {
            print("Error saving mood: \(error.localizedDescription)")
        }
    }
    
    func saveOnDemand() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error storing mood entry: \(error.localizedDescription)")
            }
        }
    }
    
    func viewRecords() {
        print("Viewing records...")
        let request: NSFetchRequest<MoodEntry> = MoodEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MoodEntry.logDate, ascending: false)]
        
        do {
            let entries = try context.fetch(request)
            if entries.isEmpty {
                print("No mood entries found.")
            } else {
                for entry in entries {
                    print("Username: \(entry.userName ?? "Unknown")")
                    print("Mood: \(entry.currentMood ?? "No mood")")
                    print("Note: \(entry.reflectionNote ?? "No note")")
                    print("Date: \(entry.logDate?.formatted() ?? "Unknown date")")
                    print("-------------------")
                }
            }
        } catch {
            print("Error fetching mood entries: \(error.localizedDescription)")
        }
    }
    
    // Fetch mood history for a user
    func getMoodHistory(for username: String) -> [MoodHistory] {
        let request: NSFetchRequest<MoodEntry> = MoodEntry.fetchRequest()
        request.predicate = NSPredicate(format: "userName == %@", username)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MoodEntry.logDate, ascending: false)]
        
        do {
            let entries = try context.fetch(request)
            return entries.map { MoodHistory(recordID:UUID(), id: $0.objectID, date: $0.logDate ?? Date(), mood: $0.currentMood ?? "---", reflection: $0.reflectionNote ?? "---") }
        } catch {
            print("Error fetching mood entries: \(error.localizedDescription)")
            return []
        }
    }
    
    func getMockMoodHistory() -> [MoodHistory] {
        // Sample NSManagedObjectID for the sake of mock data. In a real scenario, this would be fetched from CoreData
        let mockObjectID = NSManagedObjectID()
        
        // Creating mock data for MoodHistory
        let moodHistory = [
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date(), mood: "Happy", reflection: "Feeling great today!"),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-86400), mood: "Sad", reflection: "Not a good day..."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-172800), mood: "Angry", reflection: "Very frustrated with work."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-259200), mood: "Excited", reflection: "Looking forward to the weekend!"),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-345600), mood: "Neutral", reflection: "Nothing special today."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-432000), mood: "Anxious", reflection: "A bit anxious about the upcoming presentation."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-518400), mood: "Excited", reflection: "Excited to see family tomorrow."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-604800), mood: "Neutral", reflection: "Feeling indifferent."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-691200), mood: "Sad", reflection: "Woke up feeling down."),
            MoodHistory(recordID: UUID(), id: mockObjectID, date: Date().addingTimeInterval(-777600), mood: "Happy", reflection: "Had a great workout today!")
        ]
        
        return moodHistory
    }
    
    // Fetch the mood entry for a specific user and date
    private func fetchMoodEntry(for username: String, on date: Date) -> MoodEntry? {
        let request: NSFetchRequest<MoodEntry> = MoodEntry.fetchRequest()
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        request.predicate = NSPredicate(format: "userName == %@ AND logDate >= %@ AND logDate < %@", username, startOfDay as CVarArg, endOfDay as CVarArg)
        
        do {
            let entries = try context.fetch(request)
            if(entries.isEmpty){
                return nil
            }
            return entries.first
        } catch {
            print("Error fetching mood entry: \(error.localizedDescription)")
            return nil
        }
    }
    
    func clearAllForUser(username: String) throws {
        let request: NSFetchRequest<MoodEntry> = MoodEntry.fetchRequest()
        request.predicate = NSPredicate(format: "userName == %@", username)
        
        do {
            let entries = try context.fetch(request)
            if(entries.isEmpty){
                return
            }
            for entry in entries {
                context.delete(entry)
            }
        }
    }
}
