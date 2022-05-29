//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Mohammad Azam on 3/6/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import SwiftUI
import CoreMotion

enum TrackingError: Error {
    case notAvailable
    case notAuthorized
}

struct ContentView: View {
    
    private let tracker = CMMotionActivityManager()
    @State private var activityName: String = "Not Tracking"
    
    private func startTracking(handler: @escaping (CMMotionActivity?) -> Void) throws {
        
        if !CMMotionActivityManager.isActivityAvailable() {
            throw TrackingError.notAvailable
        } else if CMMotionActivityManager.authorizationStatus() == .denied {
            throw TrackingError.notAuthorized
        }
        
        self.tracker.startActivityUpdates(to: .main, withHandler: handler)
        
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(self.activityName)
                .font(.largeTitle)
            
            HStack {
                Button("Start Tracking") {
                    
                    do {
                        try self.startTracking { activity in
                            if let activity = activity {
                                self.activityName = activity.name
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                .frame(width: 120)
                .padding(10)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                
                Button("Stop Tracking") {
                    self.tracker.stopActivityUpdates()
                }.frame(width: 120)
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                
            }
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
