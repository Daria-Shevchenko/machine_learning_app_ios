//
//  ViewController.swift
//  ARWithAI
//
//  Created by Mohammad Azam on 3/6/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import Vision
import CoreML

class ViewController: UIViewController, ARSKViewDelegate, ARSessionDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    var currentFrame: ARFrame!
    var classification: String = ""
    
    lazy var classificationRequest: VNCoreMLRequest = {
        
        do {
            
            let model = try VNCoreMLModel(for: MobileNetV2().model)
            let request = VNCoreMLRequest(model: model) { request, error in
                
                // process classifications
                guard let classifications = request.results as? [VNClassificationObservation], error == nil else {
                    return
                }
                
                self.processClassifications(classifications)
                
            }
            
            request.imageCropAndScaleOption = .centerCrop
            return request
            
            
        } catch {
            print(error.localizedDescription)
            fatalError("Unable to initialize request for Machine Learning Model")
        }
        
    }()
    
    private func processClassifications(_ classifications: [VNClassificationObservation]) {
        
        if let observation = classifications.first {
            
            self.classification = observation.identifier
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.2
            let transform = simd_mul(self.currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
            
        }
        
    }
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        let labelNode = SKLabelNode(text: self.classification)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.currentFrame = sceneView.session.currentFrame
        classifyImage()
        
    }
    
    private func classifyImage() {
        
        guard let orientation = CGImagePropertyOrientation(rawValue: UInt32(UIDevice.current.orientation.rawValue)) else {
            return
        }
        
        
        let handler = VNImageRequestHandler(cvPixelBuffer: self.currentFrame.capturedImage, orientation: orientation, options: [:])
        
        DispatchQueue.global().async {
            
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
}
