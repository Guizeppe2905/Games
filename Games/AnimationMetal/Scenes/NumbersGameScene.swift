//
//  NumbersGameScene.swift
//  Games
//
//  Created by Мария Хатунцева on 05.09.2022.
//

import MetalKit

class NumbersGameScene: Scene {
    var quad: Plane
  override init(device: MTLDevice, size: CGSize) {
    quad = Plane(device: device,
                 imageName: "1621484094_29-phonoteka_org-p-fon-chisla-i-tsifri-31.png")
    super.init(device: device, size: size)
      add(childNode: quad)
      quad.position.y = 1.6
      quad.position.x = 0.1
      quad.scale = SIMD3<Float>(repeating: 0.8)
  }
  override func update(deltaTime: Float) {
    quad.rotation.z += deltaTime
  }
  
}
