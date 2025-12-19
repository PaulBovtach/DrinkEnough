//
//  TestView.swift
//  DrinkEnough
//
//  Created by Paul Bovtach on 18.12.2025.
//

import SwiftUI

struct TestView: View {
    @AppStorage("hasPassedTest") var hasPassedTest = false
    @AppStorage("cupsEstimated") var cupsAmount = 0
    @AppStorage("consumedStored") var consumedCupsStored = 0
    @AppStorage("hasFilled") var hasFilled = false
    
    @State private var age = 18
    @State private var weight = 50
    @State private var gender = "Male"
    
    let genders = ["Male", "Female"]
    var constant: Int {
        if gender == "Male"{
            return 40
        }else {
            return 30
        }
    }
    
    @State private var isResultPresented = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    
                    Section("Your Gender"){
                        Picker("Gender", selection: $gender) {
                            ForEach(genders, id: \.self){ gender in
                                Text(gender)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section("Your age"){
                        Picker("Age", selection: $age) {
                            ForEach(1..<111, id: \.self) { num in
                                Text("\(num)")
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    
                    Section("Your weight"){
                        Picker("Weight", selection: $weight){
                            ForEach(5..<181, id: \.self){ kg in
                                Text("\(kg) kg")
                            }
                        }
                        .pickerStyle(.wheel)
                        
                        Button{
                            cupsAmount = estimateCups()
                            isResultPresented = true
                        }label: {
                            HStack{
                                Text("Estimate cups a day")
                                    .font(.title2.bold())
                                    .foregroundStyle(.tint)
                                    
                            }
                        }
                    }
                    
                    
                }
            }
        }
        .alert("Your daily consume is", isPresented: $isResultPresented, actions: {
            Button("OK"){
                withAnimation {
                    consumedCupsStored = 0
                    hasPassedTest = true
                    hasFilled = false
                }
                
            }
        }, message: {
            Text("\(cupsAmount) cups")
        })
        
        .navigationTitle("Enter data for estimating")
    }
    
    func estimateCups() -> Int {
        var ageCoef: Double {
            if age < 55 {
                return 1.0
            }else if age < 65 {
                return 0.85
            }else{
                return 0.75
            }
        }
        
        let totalConsume = Double(weight) * Double(constant) * ageCoef
        let cupsConsume = ceil(totalConsume/250.0)
        
        return Int(cupsConsume)
    }
    
}

#Preview {
    TestView()
}
