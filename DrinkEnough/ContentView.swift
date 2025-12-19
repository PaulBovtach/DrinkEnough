//
//  ContentView.swift
//  DrinkEnough
//
//  Created by Paul Bovtach on 18.12.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasPassedTest") var hasPassedTest = false
    @AppStorage("hasFilled") var hasFilled = false
    
    var body: some View {
        
        if !hasPassedTest {
            TestView()
        }else if hasPassedTest && hasFilled{
            SuccessView()
        }else {
            WaterView()
        }
        
    }
}

#Preview {
    ContentView()
}
