//
//  ContentView.swift
//  Currency Converter
//
//  Created by Finhane Artur on 2024/2/4.
//

import SwiftUI

struct ContentView: View {
    @State private var itemSelected = 0
    @State private var itemSelected1 = 1
    @State private var amount: String = ""
    private let currencies = ["USD", "EUR", "GBP", "XOF"]
    
    func convert(_ convert: String) -> String {
        var conversion: Double = 1.0
        var amount = Double(convert) ?? 0.0
        var selectedCurrency = currencies[itemSelected]
        let to = currencies[itemSelected1]
        
        let usdRate = ["USD": 1.0, "EUR": 0.9225, "GBP": 0.7916, "XOF": 605.0924]
        let eurRate = ["USD": 1.0841, "EUR": 1.0, "GBP": 0.8581, "XOF": 655.09570]
        let gbpRate = ["USD": 1.2633, "EUR": 1.1653, "GBP": 1.0, "XOF": 764.3955]
        let xofRate = ["USD": 0.0017, "EUR": 0.0015, "GBP": 0.0013, "XOF":1.0]
        
        switch(selectedCurrency) {
        case "USD":
            conversion = amount * (usdRate[to] ?? 0.0)
        
        case "EUR":
            conversion = amount * (eurRate[to] ?? 0.0)
            
        case "GBP":
            conversion = amount * (gbpRate[to] ?? 0.0)
            
        case "XOF":
            conversion = amount * (xofRate[to] ?? 0.0)
        default:
            print("Not available")
        }
        //it will do the convertion and round the remainin numbers to be equally converted to the last cent, ex: 20.22
        return String(format: "%.2f", conversion)
//        return String( conversion) it will convert and show all the possible number after(.) ex: 20.22233
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Convert Currency")){
                    HStack{
//                        Coountry flag
//                        Currency code
                        Text("Amount")
                        TextField("", text: $amount)
        
                    }
                    Picker(selection: $itemSelected, label: Text("From")){
                        ForEach(0..<currencies.count){ index in
                            Text(self.currencies[index]).tag(index)
                        }
                    }
                    
                    Picker(selection: $itemSelected1, label: Text("To")){
                        ForEach(0..<currencies.count){ index in
                            Text(self.currencies[index]).tag(index)
                        }
                    }
                }
                
                Section(header: Text("Conversions")){
                    Text("\(convert(amount)) \(currencies[itemSelected1])")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
