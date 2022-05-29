//
//  CMMotionActivity+Extensions.swift
//  ActivityTracker
//
//  Created by Mohammad Azam on 3/6/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import CoreMotion

extension CMMotionActivity {
    
    var name: String {
        
        if walking { return "Walking" }
        if running { return "Running" }
        if cycling { return "Cycling" }
        if automotive { return "Driving" }
        if stationary { return "Stationary" }
        return "Unknown"
        
    }
    
}
