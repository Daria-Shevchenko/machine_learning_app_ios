//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by Mohammad Azam on 2/24/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text: String = ""
    @State private var isPositive: Bool?
    
    let model = SentimentAnalysisClassiferModel()
    
    var body: some View {
        
        let screenSize = UIScreen.main.bounds
        
        return VStack {
            TextView(text: $text)
                .frame(width: screenSize.width, height: 300)
            Spacer()
            
            (isPositive != nil ? Text(isPositive! ? "😊" : "😞") : Text("")).font(.custom("Arial",size: 100))
            
            Spacer()
    
            Button("Sentiment Analysis") {
              
                let output = try? self.model.prediction(text: self.text)
                if let output = output {
                    self.isPositive = output.label == "Pos"
                }
                
                
            }.padding()
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
