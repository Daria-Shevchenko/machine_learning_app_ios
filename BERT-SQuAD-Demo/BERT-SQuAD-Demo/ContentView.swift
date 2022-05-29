//
//  ContentView.swift
//  BERT-SQuAD-Demo
//
//  Created by Mohammad Azam on 3/9/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let model = BERT()
    
    @State private var answerLabel: String = ""
    @State private var context: String = ""
    @State private var question: String = ""
    
    var body: some View {
        
        VStack {
            
            TextView(text: $context)
                .frame(height: 300)
            
            
            TextField("Enter question", text: $question)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Answer") {
               
                DispatchQueue.global(qos: .userInitiated).async {
                    
                   let answer =  self.model.findAnswer(for: self.question, in: self.context)
                    
                    self.answerLabel = String(answer)
                    
                }
                
                
            }.padding()
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(10)
            
             Text(answerLabel)
                .font(.title)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
