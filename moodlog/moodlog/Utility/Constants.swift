//
//  Constants.swift
//  moodlog
//
//  Created by Kartik Saraf on 15/10/24.
//
struct Constants {
    static let moods : [(emoji: String, title: String)] = [
        ("😊", "Happy"),
        ("😔", "Sad"),
        ("😡", "Angry"),
        ("😰", "Anxious"),
        ("😐", "Neutral"),
        ("😃", "Excited")
    ]
    struct Strings{
        static let appName:String = "MoodLog🗒️"
        static let continueButtonText:String = "Continue"
        static let submitButtonText:String = "Submit"
        static let resetButtonText:String = "Reset"
        static let nameInputViewHeading:String = "What would you like to be called?"
        static let nameInputViewTextHint:String = "Enter your name or alias"
    }
    struct Colors{
        
    }
    struct Fonts{
        
    }
    struct Emojis{
        
    }
    struct Dimensions{
        static let standardSpacing = 20.0
        static let standardCornerRadius = 10.0
    }
    
    struct Thresholds{
        static let nameInputViewMaximumLength:Int = 10
        static let reflectionNoteMaximumLemgth:Int = 100

    }
}
