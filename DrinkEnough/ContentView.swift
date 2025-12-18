//
//  ContentView.swift
//  DrinkEnough
//
//  Created by Paul Bovtach on 18.12.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasPassedTest") var hasPassedTest = false
    
    var body: some View {
        
        if !hasPassedTest {
            TestView()
        }else {
            WaterView()
        }
        
    }
}

#Preview {
    ContentView()
}
