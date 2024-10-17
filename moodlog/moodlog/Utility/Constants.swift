//
//  Constants.swift
//  moodlog
//
//  Created by Kartik Saraf on 15/10/24.
//

import CoreFoundation
struct Constants {
    static let moods: [(emoji: String, title: String)] = [
        ("\u{1F60A}", "Happy"),  // 😊
        ("\u{1F614}", "Sad"),    // 😔
        ("\u{1F621}", "Angry"),  // 😡
        ("\u{1F630}", "Anxious"), // 😰
        ("\u{1F610}", "Neutral"), // 😐
        ("\u{1F603}", "Excited")  // 😃
    ]
    struct Strings{
        static let appName:String = "moodlog🗒️"
        static let helloText:String = "Hello"
        static let continueButtonText:String = "Continue"
        static let submitButtonText:String = "Submit"
        static let resetButtonText:String = "Reset"
        static let nameInputViewHeading:String = "What would you like to be called?"
        static let nameInputViewTextHint:String = "Enter your name or alias"
        static let moodLogPageTitle:String = "How are you feeling today?"
        static let moodLogPageReflectionNoteHint:String = "Why do you feel this way?"
    }
    struct Colors{
        
    }
    struct Fonts{
        
    }
    struct Emojis{
        
    }
    struct Dimensions{
        static let standardSpacing = CGFloat(20)
        static let standardCornerRadius = CGFloat(10)
    }
    
    struct Thresholds{
        static let nameInputViewMaximumLength:Int = 10
        static let reflectionNoteMaximumLemgth:Int = 100

    }
    struct Keys{
        static let userName:String = "userName"
    }
}
