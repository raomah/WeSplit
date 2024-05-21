//
//  ContentView.swift
//  WeSplit
//
//  Created by Mahima Rao.
//

import SwiftUI

struct ContentView: View {
    
    @State private var CheckAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var isOpenTipPicker: Bool = false
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = CheckAmount / 100 * tipSelection
        let grandTotal = tipValue + CheckAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = CheckAmount / 100 * tipSelection
        let grandTotal = tipValue + CheckAmount
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Amount", value: $CheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                        .pickerStyle(.navigationLink)
                    }
                }
                
                Section("How much do you want to tip?") {
                   
                    Button("Open Tip Picker") {
                        isOpenTipPicker = true
                    }
                }
                
                Section("Total Amount including tip:") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("That's the total amount per person:"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .fullScreenCover(isPresented: $isOpenTipPicker, content: {
                VStack {
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    Button("Done"){
                        isOpenTipPicker = false
                    }
                }
            })
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
