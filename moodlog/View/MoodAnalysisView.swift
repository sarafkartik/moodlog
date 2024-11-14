//
//  MoodAnalysisView.swift
//  moodlog
//
//  Created by Kartik Saraf on 14/11/24.
//


import SwiftUI
import Charts

struct MoodAnalysisView: View {
    var userName: String = ""
    @EnvironmentObject var moodManager: MoodManager
    @Environment(\.presentationMode) var presentationMode
    @State private var moodFrequencies: [String: Double] = [:]
    @State private var moodInsights: [String] = [String]()
    
    var body: some View {
        VStack {
            HStack {
                Text(Constants.Strings.moodFrequencyAnalysis)
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
            ScrollView (showsIndicators: false){
                VStack{
                    // Pie Chart
                    if #available(iOS 16.0, *) {
                        Chart {
                            ForEach(moodFrequencies.sorted(by: { $0.value > $1.value }), id: \.key) { mood, frequency in
                                SectorMark(
                                    angle: .value("Frequency", frequency),
                                    innerRadius: .ratio(0.3),
                                    outerRadius: .ratio(0.8)
                                )
                                .foregroundStyle(by: .value("Mood", mood))
                            }
                        }
                        .frame(height: 300)
                        .padding()
                        
                    } else {
                        Text(Constants.Strings.moodFrequencyAnalysisLable)
                            .font(.headline)
                            .foregroundColor(.gray)
                        .padding(.top, 8)         }
                    
                    // Mood Frequencies List
                    ForEach(moodFrequencies.keys.sorted(), id: \.self) { mood in
                        HStack {
                            Text(mood)
                                .font(.headline)
                            Spacer()
                            Text(String(format: "%.1f%%", moodFrequencies[mood] ?? 0))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4).padding(.horizontal, 16)
                    }
                    Divider()
                        .padding(.vertical)
                    
                    if(!moodInsights.isEmpty){
                        VStack(alignment: .leading, spacing: 16) {
                            Text(Constants.Strings.moodInsights)
                                .font(.title3)
                                .bold().padding(.bottom, -10)
                            
                            // Table with mood analysis data
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(Constants.Strings.mostPrevalentMood)
                                        .font(.headline)
                                    Spacer()
                                    Text(moodInsights[0])
                                        .font(.body)
                                }
                                Divider()
                                
                                HStack {
                                    Text(Constants.Strings.leastPrevalentMood)
                                        .font(.headline)
                                    Spacer()
                                    Text(moodInsights[1])
                                        .font(.body)
                                }
                                Divider()
                                
                                Text(Constants.Strings.resultLabel)
                                    .font(.headline)
                                Text(moodInsights[2])
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                        .padding()
                        
                        
                    }
                    
                    
                    
                    Spacer()
                }
            }
        }
        .padding()
        .onAppear {
            moodFrequencies = moodManager.calculateMoodFrequencies(forDays: 7, userName: userName)
            moodInsights = moodManager.generateMoodInsights(forDays: 7, userName: userName)
        }
        .navigationBarBackButtonHidden(true)
    }
}
struct MoodAnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        MoodAnalysisView(userName: "Kartik")
            .environmentObject(MoodManager())
    }
}
