//
//  ViewController.swift
//  DrawingApp
//
//  Created by Mohammad Azam on 3/4/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    let model = DrawingClassifier_1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.frame = view.frame
        view.addSubview(canvas)
    }
    
    @IBAction func clear() {
        self.title = ""
        canvas.clear()
    }
    
    @IBAction func classify() {
        
        let image = canvas.uiImage()
        guard let resizedImage = image.resizeTo(size: CGSize(width: 299, height: 299)),
            let buffer = resizedImage.toBuffer()
        else {
            return
        }
        
        let output = try? model.prediction(image: buffer)
        
        if let output = output {
            self.title = output.classLabel
        }
        
    }


}

