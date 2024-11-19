//
//  MoodPrediction.swift
//  moodlog
//
//  Created by Kartik Saraf on 19/11/24.
//
import SwiftUI
import CoreML

class MoodPrediction {
    private var model: MoodLogMoodPrediction?
    
    init() {
        // Load the model
        self.model = try? MoodLogMoodPrediction(configuration: MLModelConfiguration())
    }
    
    func predictMood(from moods: [String]) -> String? {
        guard let model = model else {
            print("Failed to load model")
            return nil
        }

        let input = MoodLogMoodPredictionInput(mood1: moods[0], mood2: moods[1], mood3: moods[2])

        do {
            let prediction = try model.prediction(input: input)
            return prediction.target
        } catch {
            print("Prediction error: \(error)")
            return nil
        }
    }
    
    
}

