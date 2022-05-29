//
//  TextView.swift
//  SentimentAnalysis
//
//  Created by Mohammad Azam on 2/24/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class TextViewCoordinator: NSObject, UITextViewDelegate {
    
    var control: TextView
    
    init(_ control: TextView) {
        self.control = control
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.control.text = textView.text
    }
    
}

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    typealias Coordinator = TextViewCoordinator
    @Binding var text: String
    
    func makeUIView(context: Context) -> UIViewType {
        let textView = UITextView()
        textView.backgroundColor = UIColor.lightGray
        textView.font = UIFont(name: "Arial", size: 24)
        textView.delegate = context.coordinator
        return textView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        uiView.text = text
    }
    
}


