//
//  SentimentAnalyzer.swift
//  moodlog
//
//  Created by Kartik Saraf on 18/11/24.
//
import SwiftUI
import CoreML

class SentimentAnalyzer {
    private var model: MoodLogSentimentAnalyser?

    init() {
        // Load the model
        self.model = try? MoodLogSentimentAnalyser(configuration: MLModelConfiguration())
    }

    func analyzeSentiment(for reflectionNote: String) -> SentimentAnalysisResult? {
        guard let model = model else {
            print("Model not loaded.")
            return nil
        }

        let input = MoodLogSentimentAnalyserInput(text: reflectionNote)

        do {
            let output = try model.prediction(input: input)
            let sentimentLabel = output.label

            return SentimentAnalysisResult(analysedMood: sentimentLabel)
        } catch {
            print("Error during prediction: \(error)")
            return nil
        }
    }
}
