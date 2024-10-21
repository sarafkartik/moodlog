//
//  Constants.swift
//  moodlog
//
//  Created by Kartik Saraf on 15/10/24.
//

import CoreFoundation
import SwiftUICore
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
        static let okButtonText:String = "OK"
        static let continueButtonText:String = "Continue"
        static let submitButtonText:String = "Submit"
        static let resetButtonText:String = "Reset"
        static let nameInputViewHeading:String = "What would you like to be called?"
        static let nameInputViewTextHint:String = "Enter your name or alias"
        static let moodLogPageTitle:String = "How are you feeling today?"
        static let moodLogPageReflectionNoteHint:String = "Why do you feel this way?"
        static let unknownMood:String = "Unknown"
        static let success:String = "Success!"
        static let moodSavedMessage:String = "🗒️ Your mood has been logged successfully."
    }
    struct Colors{
        
        
        static let teal = Color(red: 102 / 255, green: 178 / 255, blue: 178 / 255)
        static let lavender = Color(red: 179 / 255, green: 157 / 255, blue: 217 / 255)
        static let palePink = Color(red: 242 / 255, green: 182 / 255, blue: 193 / 255)
        
        static let softGreen = Color(red: 129 / 255, green: 199 / 255, blue: 132 / 255)
        static let softRed = Color(red: 239 / 255, green: 83 / 255, blue: 80 / 255)
        static let softGray = Color(red: 189 / 255, green: 189 / 255, blue: 189 / 255)
        static let softBlue = Color(red: 79 / 255, green: 195 / 255, blue: 247 / 255)
        
        
    }
    struct Fonts{
        
    }
    struct Emojis{
        
    }
    struct Images{
        static let xMark:Image = Image(systemName: "xmark.circle.fill")
    }
    
    struct Keys{
        static let userName:String = "userName"
    }
}
