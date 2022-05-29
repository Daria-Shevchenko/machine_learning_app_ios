//
//  ContentView.swift
//  ImageClassificationSwiftUI
//
//  Created by Mohammad Azam on 2/3/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let model = GPT2(strategy: .greedy)
    
    @State private var currentIndex: Int = 0
    @State private var predictionLabel: String = ""
    @State private var startingText: String = ""
    
    private let prompts = [
           "Before boarding your rocket to Mars, remember to pack these items",
           "I was planning to visit NY for my vacation but Corona Virus",
           "Yesterday my car broke down, luckily I had AAA membership.",
           "Today, scientists confirmed the worst possible outcome: the massive asteroid will collide with Earth",
           "Hugging Face is a company that releases awesome projects in machine learning because",
       ]
    
    var body: some View {
        VStack {
           
            Text(self.prompts[self.currentIndex] + self.predictionLabel)
            
            HStack {
                Button("Previous") {
                    
                    if self.currentIndex >= self.prompts.count {
                        self.currentIndex = self.currentIndex - 1
                    } else {
                        self.currentIndex = 0
                    }
                    
                    }.padding()
                    .foregroundColor(Color.white)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .frame(width: 100)
                
                Button("Next") {
                    if self.currentIndex < self.prompts.count - 1 {
                        self.currentIndex = self.currentIndex + 1
                    } else {
                        self.currentIndex = 0
                    }
                }
                .padding()
                .foregroundColor(Color.white)
                .frame(width: 100)
                .background(Color.gray)
                .cornerRadius(10)
            
                
                
            }.padding()
            
            Button("Generate") {
                
                // generate the text
                let text = self.prompts[self.currentIndex]
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                   _ = self.model.generate(text: text) { completion, _ in
                        
                    DispatchQueue.main.async {
                        self.predictionLabel = completion
                    }
                        
                    }
                    
                }
                
                
            }.padding()
            .foregroundColor(Color.white)
            .background(Color.green)
            .cornerRadius(8)
            
            Text("")
                .font(.largeTitle)
            .padding()
        }
        
        .onAppear {
             //self.startingText = self.prompts.first!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
