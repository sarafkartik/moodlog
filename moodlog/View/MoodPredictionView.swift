//
//  MoodPredictionView.swift
//  moodlog
//
//  Created by Kartik Saraf on 19/11/24.
//


import SwiftUI

struct MoodPredictionView: View {
    
    var userName: String = ""
    @EnvironmentObject var moodManager: MoodManager
    @Environment(\.presentationMode) var presentationMode
    @State private var moodHistory: [MoodHistory] = []
    @State private var predictedMood: String? = nil
    @State private var predictionAvailable = false
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.Strings.moodPredictionLabel)
                    .foregroundColor(Constants.Colors.lavender).bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: {
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Constants.Images.xMark
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }.padding()
            Spacer()
            if (predictionAvailable) {
                VStack {
                    Text(Constants.Strings.lastThreeLoggedMoods)
                        .foregroundColor(Color.black.opacity(0.8))
                        .bold()
                        .font(.headline)
                        .padding()
                    
                    ForEach(moodHistory.prefix(3), id: \.recordID) { mood in
                        HStack {
                            Text(MoodHistory.getEmoji(mood: mood.mood))
                                .font(.system(size: 50)).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                            VStack(alignment: .leading) {
                                Text(mood.mood)
                                    .font(.headline)
                                    .padding(.top, 2)
                                Text(mood.reflection)
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                Text(formatter.string(from: mood.date))  // Formatted date
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        
                        .padding()
                    }
                    
                    Divider()
                    
                    // Mood Prediction
                    if let prediction = predictedMood {
                        VStack{
                            Text(Constants.Strings.moodPredictionForTomorrow)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text(MoodHistory.getEmoji(mood: prediction))
                                    .font(.system(size: 50)).padding(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: -10))
                                Text(prediction)
                                    .font(.headline)
                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 14, trailing:0))
                                Spacer()
                                
                                
                            }.padding().background(Constants.Colors.mutedPeach)
                        }
                        Divider()
                        Text(Constants.Strings.moodPredictionDisclaimer).font(.callout).padding(EdgeInsets(top: -3, leading: 8, bottom: 5, trailing: 8))
                        Spacer()
                        
                    }
                }
                
            } else {
                Text(Constants.Strings.moodPredictionEmptyLabel)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Constants.Colors.lavender)
                    .padding()
                Spacer()
                
            }
            
        }
        .onAppear {
            loadMoodHistoryAndPredictMood()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadMoodHistoryAndPredictMood(){
        self.moodHistory = moodManager.getMockMoodHistory()
        //self.moodHistory = moodManager.getMoodHistory(for: userName)
        if(moodHistory.count >= 3){
            predictionAvailable = true
            let prediction = moodManager.generateMoodPrediction(moods: moodHistory.prefix(3).map({ mh in
                mh.mood
            }))
            if(prediction != nil || !prediction!.isEmpty){
                predictedMood = prediction!
            }
        }
        else{
            predictionAvailable = false
        }
    }
    
    
}

struct MoodPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        MoodPredictionView(userName: "Kartik").environmentObject(MoodManager())
    }
}
