//
//  WaterView.swift
//  DrinkEnough
//
//  Created by Paul Bovtach on 18.12.2025.
//

import SwiftUI

struct Wave: Shape {
    var offset: Angle
    var amplitude: CGFloat = 10
    var waveLength: CGFloat = 200
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // 1. Change this to 0 to start the water at the top of the view
        let topEdge = 0.0
        
        path.move(to: CGPoint(x: 0, y: topEdge))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / waveLength
            let sine = sin(relativeX * .pi * 2 + offset.radians)
            
            // 2. Wave now oscillates around the top edge
            let y = topEdge + sine * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        // 3. This ensures the color fills the entire screen height
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

struct WaterView: View {
    
    @AppStorage("cupsEstimated") var cupsAmount = 0
    @AppStorage("consumedStored") var consumedCupsStored = 0
    @AppStorage("hasPassedTest") var hasPassedTest = false
    
    @State private var consumedCups = 0
    @State private var showSuccess = false
    
    var waveHeight: Double {
        guard consumedCups > 0 else { return 970 }
        
        let remaining = cupsAmount - consumedCups
        let ratio = Double(remaining) / Double(cupsAmount)
        
        return (1000.0 * ratio)
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
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
                    .frame(maxHeight: 1000 - waveHeight) //adjust
                    .ignoresSafeArea(edges: .bottom)
                }
                .onAppear{
                    consumedCups = consumedCupsStored
                }
                .onChange(of: consumedCups) {
                        consumedCupsStored = consumedCups
                    if (cupsAmount - consumedCups) == 0 {
                        showSuccess = true
                    }
                }
                .ignoresSafeArea()
                
                //functionality
                VStack{
                    Button{
                        if consumedCups != cupsAmount {
                            withAnimation {
                                consumedCups += 1
                                consumedCupsStored = consumedCups
                            }
                        }else{
                            showSuccess = true
                        }
                        
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.ultraThinMaterial)
                                .frame(width: 200, height: 200)
                            VStack{
                                Text("Today's goal: \(cupsAmount)")
                                    .font(.title2.bold())
                                    .foregroundStyle(.indigo)
                                Spacer()
                                
                                Text("Consumed: \(consumedCups)")
                                    .font(.title3)
                                    .foregroundStyle(.indigo)
                                Spacer()
                                
                                HStack{
                                    Text("Left:")
                                        .font(.title3)
                                        .foregroundStyle(.indigo)
                                    Text("\(cupsAmount - consumedCups)")
                                        .font(.title3.bold())
                                        .foregroundStyle(.red)
                                }
                                
                            }
                            .frame(width: 200, height: 100)
                        }
                        
                    }
                }
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
        .alert("Filled!", isPresented: $showSuccess) {
            Button("OK"){}
        } message: {
            Text("You finished your daily plan of water consume!")
        }
        
        
        
        
    }
}

#Preview {
    WaterView()
}
