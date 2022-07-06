//
//  Primitives.swift
//  Games
//
//  Created by Мария Хатунцева on 27.06.2022.
//

import MetalKit

class Cube: Primitive {

  override func buildVertices() {
    vertices = [
      Vertex(position:  SIMD3<Float>(-1, 1, 1),
             color:     SIMD4<Float>(1, 0, 0, 1),
             texture:   SIMD2<Float>(0, 0)),
      Vertex(position:  SIMD3<Float>(-1, -1, 1),
             color:     SIMD4<Float>(0, 1, 0, 1),
             texture:   SIMD2<Float>(0, 1)),
      Vertex(position:  SIMD3<Float>(1, -1, 1),
             color:     SIMD4<Float>(0, 0, 1, 1),
             texture:   SIMD2<Float>(1, 1)),
      Vertex(position:  SIMD3<Float>(1, 1, 1),
             color:     SIMD4<Float>(1, 0, 1, 1),
             texture:   SIMD2<Float>(1, 0)),
      
      Vertex(position:  SIMD3<Float>(-1, 1, -1),
             color:     SIMD4<Float>(0, 0, 1, 1),
             texture:   SIMD2<Float>(1, 1)),
      Vertex(position:  SIMD3<Float>(-1, -1, -1),
             color:     SIMD4<Float>(0, 1, 0, 1),
             texture:   SIMD2<Float>(0, 1)),
      Vertex(position:  SIMD3<Float>(1, -1, -1),
             color:     SIMD4<Float>(1, 0, 0, 1),
             texture:   SIMD2<Float>(0, 0)),
      Vertex(position:  SIMD3<Float>(1, 1, -1),
             color:     SIMD4<Float>(1, 0, 1, 1),
             texture:   SIMD2<Float>(1, 0)),
    ]
    indices = [
      0, 1, 2,     0, 2, 3,
      4, 6, 5,     4, 7, 6,
      4, 5, 1,     4, 1, 0,
      3, 6, 7,     3, 2, 6,
      4, 0, 3,     4, 3, 7,
      1, 5, 6,     1, 6, 2   
    ]
  }
}
