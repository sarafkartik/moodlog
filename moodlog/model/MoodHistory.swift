//
//  MoodHistory.swift
//  moodlog
//
//  Created by Kartik Saraf on 11/11/24.
//


import Foundation
import CoreData

struct MoodHistory: Identifiable {
    var recordID: UUID
    var id: NSManagedObjectID
    var date: Date
    var mood: String
    var reflection: String
    
    static func getEmoji(mood: String) -> String {
        switch mood {
        case "Happy":
            return "😊"
        case "Sad":
            return "😔"
        case "Angry":
            return "😡"
        case "Anxious":
            return "😰"
        case "Neutral":
            return "😐"
        case "Excited":
            return "😃"
        default:
            return "😶"  // Default case for unrecognized moods (could be a neutral face)
        }
    }
}
