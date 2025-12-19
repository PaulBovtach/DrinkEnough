//
//  SuccessView.swift
//  DrinkEnough
//
//  Created by Paul Bovtach on 19.12.2025.
//

import SwiftUI

struct SuccessView: View {
    @AppStorage("hasPassedTest") var hasPassedTest = false
    var body: some View {
        NavigationStack{
            ZStack{
                Circle()
                    .foregroundStyle(.indigo)
                    .frame(maxWidth: 300)
                Circle()
                    .frame(maxWidth: 300)
                    .foregroundStyle(.ultraThinMaterial)
                Text("You've finished your daily plan of water consume")
                    .multilineTextAlignment(.center)
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .frame(width: 300)
                
                VStack(){
                    Spacer()
                    TimelineView(.animation) { timeline in
                        let date = timeline.date.timeIntervalSinceReferenceDate
                        let angle = Angle(radians: date * 4) // Controls speed
                        
                        ZStack {
                            // Background Wave (lighter)
                            Wave(offset: angle, amplitude: 15, waveLength: 250)
                                .fill(Color.blue.opacity(0.4))
                                .offset(y: 10)
                            
                            // Foreground Wave (darker)
                            Wave(offset: angle + Angle(degrees: 90), amplitude: 12, waveLength: 200)
                                .fill(Color.blue)
                        }
                    }
                    .frame(maxHeight: 220) //adjust
                }
                .ignoresSafeArea()
                
                VStack(){
                    TimelineView(.animation) { timeline in
                        let date = timeline.date.timeIntervalSinceReferenceDate
                        let angle = Angle(radians: date * 4) // Controls speed
                        
                        ZStack {
                            // Background Wave (lighter)
                            Wave(offset: angle, amplitude: 15, waveLength: 250)
                                .fill(Color.blue.opacity(0.4))
                                .offset(y: 10)
                            
                            // Foreground Wave (darker)
                            Wave(offset: angle + Angle(degrees: 90), amplitude: 12, waveLength: 200)
                                .fill(Color.blue)
                        }
                    }
                    .frame(maxHeight: 300) //adjust
                    .scaleEffect(-1)
                    
                    Spacer()
                }
                .ignoresSafeArea()
                    
                    
            }
            .navigationTitle("DrinkEnough")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Change data"){
                            withAnimation {
                                hasPassedTest = false
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.down.left")
                    }

                }
            }
        }
    }
}

#Preview {
    SuccessView()
}
