//
//  ARViewContainer.swift
//  RealityPlus
//
//  Created by Martin Brian on 30/5/21.
//

import SwiftUI
import RealityKit
import ARKit


struct ARViewContainer: UIViewRepresentable {
    
    @Binding var finishedCoaching: Bool
    @Binding var addBall: Bool
    @Binding var score: Int
    
    @State private var ballAdded: Bool = false
    
    func makeCoordinator() -> ARViewCoordinator {
        ARViewCoordinator(container: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<ARViewContainer>) -> ARView {
        let arView = ARView(frame: .zero)
        let coachingOverlay = ARCoachingOverlayView()

        arView.session.delegate = context.coordinator
        coachingOverlay.delegate = context.coordinator
        coachingOverlay.session = arView.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .tracking
        coachingOverlay.setActive(true, animated: true)
        
        arView.setupGestures()
        arView.addSubview(coachingOverlay)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        DispatchQueue.main.async {
            if addBall && !ballAdded {
                let sphere = Sphere(position: SIMD3(2.0, 2.0, 2.0))
                
                uiView.scene.anchors.append(sphere)
                print("in dispatch")
                self.ballAdded = true
                
            }
        }
    }
}

class ARViewCoordinator: NSObject, ARCoachingOverlayViewDelegate, ARSessionDelegate {
    var parent: ARViewContainer
    
    init(container: ARViewContainer) {
        self.parent = container
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        parent.finishedCoaching = true
    }
    
    public func tapHandler(){
        self.parent.score+=1
    }
}
