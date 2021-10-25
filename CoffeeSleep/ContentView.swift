//  ContentView.swift
//  CoffeeSleep
//
//  Created by Sena Lee on 10/25/21.
//

import SwiftUI

struct ContentView: View {
    @State var wakeTime = Date()
    @State var sleepAmount = 8.0
    @State var numCoffee = 2
    
    let model = CoffeeSleepCalc()
    
    var body: some View {
        Form {
            Text("What time do you want to wake up?")
                .padding()
            DatePicker("Please enter a time:", selection: $wakeTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
            
            Text("How much sleep do you want?")
                .padding()
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount) hours")
            }
            .padding()
            Stepper(value: $numCoffee, in: 1...20) {
                Text("\(numCoffee) cups")
            }
            .padding()
            Button {
                let components = Calendar.current.dateComponents([.hour,.minute], from: wakeTime)
                let hour = (components.hour ?? 0) * 360
                let minute = (components.minute ?? 0 ) * 60
                let wake = Double(hour + minute)
                
                do {
                    let prediction = try model.prediction(wake: wake, estimatedSleep: sleepAmount, coffee: Double(numCoffee))
                    let sleepTime = wakeTime - prediction.actualSleep
                } catch {
                    print("an error occurred")
                }
            } label: {
                Text("Calculate Sleep")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
