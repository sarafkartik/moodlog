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
    static let moodStrings = ["Happy", "Sad", "Angry","Anxious","Neutral", "Excited"]
    
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
        static let moodSavedMessage:String = "🗒️ Mood logged successfully."
        //Menu Items
        static let moodHistory:String = "Mood History"
        static let moodPrediction:String = "Mood Prediction"
        static let moodAnalysis:String = "Mood Analysis"
        static let cleanSlate:String = "Clean Slate!"
        static let moodTrendsLast7Days = "Mood Trends from the Last 7 Days"
        static let noMoodsLoggedYet:String = "Log mood at least once to unlock this feature."
        static let moodFrequencyAnalysis:String = "Mood Analysis"
        static let moodFrequencyAnalysisLabel:String = "Mood Frequency Analysis"
        static let moodInsights:String = "Mood Insights:\n"
        static let leastPrevalentMood:String = "Least Prevalent Mood"
        static let mostPrevalentMood:String = "Most Prevalent Mood"
        static let moodFlexibilityMessage:String = "There’s a good variation in your moods, indicating emotional felxibility.\n"
        static let moodStabilityMessagePrefix:String = "You've mostly felt "
        static let moodStabilityMessageSuffix:String = ", showing mood stability.\n"
        static let resultLabel:String = "*Cumulative Snetiment Analysis"
        static let moodPredictionLabel:String = "Mood Prediction"
        static let moodPredictionEmptyLabel = "Log for at least 3 days to unlock this feature."
        static let moodAnalysisEmptyLabel = "Log mood at least once to unlock this feature."
        static let lastThreeLoggedMoods:String = "Your last 3 logged moods..."
        static let moodPredictionForTomorrow = "*Mood Prediction for tomorrow:"
        static let moodPredictionDisclaimer = "*This app uses Artificial Intelligence for mood prediction, and the results may not always be accurate."
        static let sentimentAnalysisDisclaimer = "*This app uses Artificial Intelligence for sentiment analysis, and the results may not always be accurate."
        

        
    }
    struct Colors{
        
        
        static let teal = Color(red: 102 / 255, green: 178 / 255, blue: 178 / 255)
        static let lavender = Color(red: 179 / 255, green: 157 / 255, blue: 217 / 255)
        static let palePink = Color(red: 242 / 255, green: 182 / 255, blue: 193 / 255)
        static let softLavender = Color(red: 210 / 255, green: 182 / 255, blue: 255 / 255)
        static let mutedPeach = Color(red: 255 / 255, green: 204 / 255, blue: 179 / 255)
        static let powderBlue = Color(red: 176 / 255, green: 224 / 255, blue: 230 / 255)
        static let softMint = Color(red: 184 / 255, green: 255 / 255, blue: 192 / 255)
        static let paleYellow = Color(red: 255 / 255, green: 255 / 255, blue: 0 / 255)
        static let lightCoral = Color(red: 255 / 255, green: 160 / 255, blue: 122 / 255)
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
        static let hamburger:Image =  Image(systemName: "line.horizontal.3")
    }
    
    struct Keys{
        static let userName:String = "userName"
    }
}
