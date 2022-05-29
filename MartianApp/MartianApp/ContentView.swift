//
//  ContentView.swift
//  MartianApp
//
//  Created by Mohammad Azam on 3/13/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfSolarPanels: Double = 5.0
    @State private var numberOfGreenHouses: Double = 1.0
    @State private var size: String = ""
    @State private var predictedPrice: String = ""
    
    let model = MartianPricesModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Number of Solar Panels")
                        .fontWeight(.bold)
                    Picker("Number of Solar Panels", selection: self.$numberOfSolarPanels) {
                        Text("2").tag(2.0)
                        Text("5").tag(5.0)
                        Text("7").tag(7.0)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Text("Number of Green Houses")
                        .fontWeight(.bold)
                    Picker("Number of Solar Panels", selection: self.$numberOfGreenHouses) {
                        Text("1").tag(1.0)
                        Text("2").tag(2.0)
                        Text("3").tag(3.0)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Size", text: self.$size)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        .navigationBarTitle("Martian Housing")
                
                    
                    
                }.padding()
                
                Button("Calculate Price") {
                    
                    let output =  try? self.model.prediction(solarPanels: self.numberOfSolarPanels, greenhouses: self.numberOfGreenHouses, size: Double(self.size) ?? 200)
                    
                    if let output = output {
                         self.predictedPrice = output.price < 0 ? "N/A" : "$\(output.price.withCommas())"
                    }
                    
                    
                }.padding(10)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
                Spacer()
                
                Text(self.predictedPrice)
                    .font(.title)
                
                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
