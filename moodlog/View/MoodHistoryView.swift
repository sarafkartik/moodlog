//
//  MoodHistoryView.swift
//  moodlog
//
//  Created by Kartik Saraf on 11/11/24.
//


import SwiftUI

struct MoodHistoryView: View {
    var userName: String = ""
    @EnvironmentObject var moodManager: MoodManager
    @Environment(\.presentationMode) var presentationMode
    @State private var moodHistory: [MoodHistory] = []
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.Strings.moodHistory)
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
            MoodComparisonChart(moodHistory: filteredMoodHistory)
            List(filteredMoodHistory, id: \.recordID) { mood in
                HStack {
                    Text(mood.getEmoji(mood: mood.mood))
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
                .padding(.vertical, 5)
            }
            .onAppear {
                loadMoodHistory()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func loadMoodHistory() {
        //self.moodHistory = moodManager.getMockMoodHistory()
        self.moodHistory = moodManager.getMoodHistory(for: userName)
    }
    
    // Filter mood history to include only the last 7 days
    var filteredMoodHistory: [MoodHistory] {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return moodHistory.filter { mood in
            mood.date >= sevenDaysAgo
        }
    }
}

struct MoodComparisonChart: View {
    var moodHistory: [MoodHistory]
    let moods = Constants.moodStrings
    private var moodPercentages: [String: Double] {
        var moodCounts = [String: Int]()
        for mood in moods {
            moodCounts[mood] = 0
        }
        
        for moodHistoryEntry in moodHistory {
            if let count = moodCounts[moodHistoryEntry.mood] {
                moodCounts[moodHistoryEntry.mood] = count + 1
            }
        }
        
        var percentages = [String: Double]()
        for (mood, count) in moodCounts {
            percentages[mood] = (Double(count) / 7.0) * 100.0
        }
        
        return percentages
    }
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom, spacing: 2) {
                ForEach(moods, id: \.self) { mood in
                    VStack {
                        Text("\(Int(moodPercentages[mood] ?? 0))%")
                            .font(.caption)
                            .frame(width: 60)
                        Rectangle()
                            .fill(Constants.Colors.palePink)
                            .frame(width: 40, height: CGFloat(moodPercentages[mood] ?? 0) * 2)
                            .cornerRadius(5)
                        Text(mood)
                            .font(.caption)
                            .frame(width: 60)
                        
                    }
                    
                }
            }.frame(alignment: .top)
                .padding()
            Text(Constants.Strings.moodTrendsLast7Days)
                .font(.caption).bold()
                .frame(alignment: .bottom).padding(EdgeInsets(top: 1, leading: 0, bottom: 8, trailing: 0))
        }.frame(height: 300, alignment: .bottom).padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}

struct MoodHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MoodHistoryView(userName: "Kartik").environmentObject(MoodManager())
    }
}


