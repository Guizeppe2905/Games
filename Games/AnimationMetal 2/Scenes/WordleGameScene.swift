//
//  WordleGameScene.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import MetalKit

class WordleGameScene: Scene {

    var quad: Plane

  override init(device: MTLDevice, size: CGSize) {
   
    quad = Plane(device: device,
                 imageName: "planet-007.png")
    
    super.init(device: device, size: size)
    
      add(childNode: quad)
 
    //  quad.scale = SIMD3<Float>(repeating: 0.8)
   //   quad.position.z = -5
  //    cube.position.z = 3
      quad.position.y = 1.6
      quad.position.x = 0.1
  
  }
  
  override func update(deltaTime: Float) {
    quad.rotation.z += deltaTime
  }
  
}

