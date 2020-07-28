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
    @State private var wakeUp = Date()
    var body: some View {
//        Form{
//            Stepper(value: $sleepAmount, in: 1...24, step: 0.25){
//                Text("\(adaptDecimalToHours(sleepAmount: sleepAmount))")
//            }
//        }
        
        DatePicker("Please enter a date", selection: $wakeUp, in: Date()..., displayedComponents: .hourAndMinute)
            .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//func adaptDecimalToHours(sleepAmount: Double) -> String {
//    var message = ""
//    let sleepHours = Int(sleepAmount * 60) / 60
//    let sleepMin = Int(sleepAmount * 60) % 60
//    var hours = ""
//    var minutes = ""
//
//    if(sleepHours == 1){
//        hours = "hour"
//    }
//    else {
//        hours = "hours"
//    }
//
//    if(sleepMin != 0){
//        minutes = " and \(sleepMin) minutes"
//    }
//
//    message = "\(sleepHours) \(hours)\(minutes)"
//
//    return message
//}
