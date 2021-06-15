import SwiftUI
import RealityKit
import ARKit


class Sphere: Entity, HasModel, HasCollision, HasPhysics, HasPhysicsMotion, HasAnchoring {
    let color: UIColor = UIColor.blue
    var radius: Float = 1
    var angularVelocity: SIMD3<Float> = SIMD3(2.0, 2.0, 2.0)
    var linearVelocity: SIMD3<Float> = SIMD3(0.0, 0.0, 0.0)
    var textureName: String = "WhereIsWally"
    
    required init() {
        
        super.init()
        
        self.components[CollisionComponent] = CollisionComponent(
              shapes: [ShapeResource.generateSphere(radius: radius)],
              mode: .trigger,
              filter: .sensor
        )
        
        let kinematics: PhysicsBodyComponent = .init(massProperties: .default,
                                                     material: nil,
                                                     mode: .kinematic)

        let motion: PhysicsMotionComponent = .init(linearVelocity: linearVelocity, angularVelocity: angularVelocity)
        
        self.components.set(kinematics)
        self.components.set(motion)
        
        
        let texture = try! TextureResource.load(named: textureName)
        var material = SimpleMaterial()
        material.baseColor = MaterialColorParameter.texture(texture)
        
        self.components[ModelComponent] = ModelComponent(
          mesh: MeshResource.generateSphere(radius: radius),
          materials: [
            material
          ]
        )
        
    }
    
    convenience init(position: SIMD3<Float>) {
        self.init()
        self.position = position
    }
    
    convenience init(position: SIMD3<Float>, radius: Float) {
        self.init()
        self.position = position
        self.radius = radius
    }
    
}

