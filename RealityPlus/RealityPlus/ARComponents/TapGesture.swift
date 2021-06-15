import RealityKit
import Foundation
import UIKit
import ARKit

extension ARView{
    
    func setupGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard let coordinator = self.session.delegate as? ARViewCoordinator else{ print("GOOD NIGHT"); return }
        guard let touchInView = sender?.location(in: self) else {
            return
        }
        print("in handleTap")
        let entities = self.entities(at: touchInView)
        
        print(self.entity(at: touchInView)?.name.debugDescription ?? "")
        print(self.entity(at: touchInView)?.position.debugDescription ?? "")
        
        if !entities.isEmpty {
            
            coordinator.tapHandler()
        }
    }
}
