//
//  XOGameScene.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import MetalKit

class XOGameScene: Scene {

    var quad: Plane
    var quad2: Plane
    var quad3: Plane
    var quad4: Plane
    var quad5: Plane

  override init(device: MTLDevice, size: CGSize) {
    
      quad = Plane(device: device,
                 imageName: "xo.png")
      quad2 = Plane(device: device,
                        imageName: "unnamed.png")
      quad3 = Plane(device: device,
                   imageName: "xo.png")
      quad4 = Plane(device: device,
                   imageName: "xo.png")
      quad5 = Plane(device: device,
                   imageName: "xo.png")
      
    super.init(device: device, size: size)
      add(childNode: quad)
      add(childNode: quad2)
      add(childNode: quad3)
      add(childNode: quad4)
      add(childNode: quad5)
      quad2.scale = SIMD3<Float>(repeating: 0.4)
      quad.scale = SIMD3<Float>(repeating: 0.2)
      quad3.scale = SIMD3<Float>(repeating: 0.2)
      quad4.scale = SIMD3<Float>(repeating: 0.2)
      quad5.scale = SIMD3<Float>(repeating: 0.2)
      quad.position.y = 0.85
      quad.position.x = -0.4
      quad2.position.y = 1.2
      quad3.position.y = 1.6
      quad3.position.x = -0.4
      quad4.position.y = 1.6
      quad4.position.x = 0.4
      quad5.position.y = 0.85
      quad5.position.x = 0.4
  }
  override func update(deltaTime: Float) {
      quad.rotation.y += deltaTime
      quad2.rotation.z += deltaTime
      quad3.rotation.y += deltaTime
      quad4.rotation.y += deltaTime
      quad5.rotation.y += deltaTime
  }
}
