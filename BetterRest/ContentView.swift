//
//  ContentView.swift
//  BetterRest
//
//  Created by Arthur Mendonça Sasse on 28/07/20.
//  Copyright © 2020 Arthur Mendonça Sasse. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var showingAlert = false
    
//    @State private var bedtime = ""
    
    var body: some View {
        NavigationView{
            
            Form{
                Section (header: Text("When do you want to wake up?")
                    .font(.body)
                    ){
                    DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
//                        .datePickerStyle(WheelDatePickerStyle())
                }
                    
                Section(header: Text("Desired amount of sleep:").font(.body)){
                    Stepper(value: $sleepAmount, in: 1...24, step: 0.25){
                        Text("\(adaptDecimalToHours(sleepAmount: sleepAmount))")
                    }
                }
                
                Section(header: Text("Daily coffee intake:").font(.body)){
                    Stepper(value: $coffeeAmount, in: 0...20){
                        if (coffeeAmount == 1){
                            Text("\(coffeeAmount) cup")
                        }
                        else{
                            Text("\(coffeeAmount) cups")
                        }
                    }
//                    Picker("Coffee amount in cups", selection: $coffeeAmount){
//                        ForEach(0..<21){ number in
//                            if(number == 1){
//                                Text("1 cup")
//                            }
//                            else{
//                                Text("\(number) cups")
//                            }
//                        }
//                    }
//                    .pickerStyle(DefaultPickerStyle())
                }
                
                Section(header: Text("Ideal bedtime for you:").font(.body)){
                    Text("\(calculateBedTime())")
//                    HStack{
//                        Text("\(bedtime)")
//                        Spacer()
//                        Button(action: calculateBedTime){
//                            Text("Calculate")
//                        }
//                    }
                }
            }
            .navigationBarTitle("BetterRest")
//            .alert(isPresented: $showingAlert){
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    
    func calculateBedTime() -> String {
        let sleepCalculator = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var bedtime = ""
        
        do {
            let prediction = try
                sleepCalculator.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            bedtime = formatter.string(from: sleepTime)
            
//            alertTitle = "Your ideal bedtime is..."
//            alertMessage = formatter.string(from: sleepTime)
            
        } catch {
//            alertTitle = "Error"
//            alertMessage = "There was an error predicting your ideal sleep time"
            bedtime = "Error"
        }
        
//        showingAlert = true
        return bedtime
    }
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func adaptDecimalToHours(sleepAmount: Double) -> String {
    var message = ""
    let sleepHours = Int(sleepAmount * 60) / 60
    let sleepMin = Int(sleepAmount * 60) % 60
    var hours = ""
    var minutes = ""

    if(sleepHours == 1){
        hours = "hour"
    }
    else {
        hours = "hours"
    }

    if(sleepMin != 0){
        minutes = " and \(sleepMin) minutes"
    }

    message = "\(sleepHours) \(hours)\(minutes)"

    return message
}
