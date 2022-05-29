//
//  UIView+Extensions.swift
//  DrawingApp
//
//  Created by Mohammad Azam on 3/4/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func uiImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { (context) in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        
    }
    
}
