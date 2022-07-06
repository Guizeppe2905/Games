//
//  GameScene.swift
//  Games
//
//  Created by Мария Хатунцева on 26.06.2022.
//

import MetalKit

class GameScene: Scene {

    var quad: Plane
    var cube: Cube
  override init(device: MTLDevice, size: CGSize) {
    cube = Cube(device: device)
    quad = Plane(device: device,
                 imageName: "p.png")
    
    super.init(device: device, size: size)
      add(childNode: cube)
      add(childNode: quad)
      cube.scale = SIMD3<Float>(repeating: 0.6)
      quad.scale = SIMD3<Float>(repeating: 0.5)
      quad.position.y = 1.5
      cube.position.y = 1.3
  }
  override func update(deltaTime: Float) {
    cube.rotation.y += deltaTime
  }
  
}
