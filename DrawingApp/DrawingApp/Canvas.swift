//
//  Canvas.swift
//  DrawingApp
//
//  Created by Mohammad Azam on 3/4/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class Canvas: UIView {
    
    var startingPoint: CGPoint = CGPoint.zero
    var currentPoint: CGPoint = CGPoint.zero
    var path: UIBezierPath!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        startingPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        currentPoint = touch.location(in: self)
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: currentPoint)
        
        startingPoint = currentPoint
        
        drawShapeLayer()
    }
    
    private func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2.0
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    func clear() {
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }
}
