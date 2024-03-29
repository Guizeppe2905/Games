//
//  Primitives.swift
//  Games
//
//  Created by Мария Хатунцева on 27.06.2022.
//

import MetalKit

class Primitive: Node {
var vertices: [Vertex] = []
var indices: [UInt16] = []
  
  var vertexBuffer: MTLBuffer?
  var indexBuffer: MTLBuffer?
  
  var time: Float = 0
  
    var modelConstants = ModelConstants()
    
    var pipelineState: MTLRenderPipelineState!
    var fragmentFunctionName: String = "fragment_shader"
    var vertexFunctionName: String = "vertex_shader"
    
    var vertexDescriptor: MTLVertexDescriptor {
      let vertexDescriptor = MTLVertexDescriptor()
      
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
      
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        vertexDescriptor.attributes[1].bufferIndex = 0
        
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = MemoryLayout<SIMD3<Float>>.stride + MemoryLayout<SIMD4<Float>>.stride
        vertexDescriptor.attributes[2].bufferIndex = 0
      
      vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
      
      return vertexDescriptor
    }
    
    var texture: MTLTexture?
    
    var maskTexture: MTLTexture?
    
    init(device: MTLDevice) {
      super.init()
        buildVertices()
      buildBuffers(device: device)
      pipelineState = buildPipelineState(device: device)
    }

    init(device: MTLDevice, imageName: String) {
      super.init()
      if let texture = setTexture(device: device, imageName: imageName) {
        self.texture = texture
        fragmentFunctionName = "textured_fragment"
      }
        buildVertices()
      buildBuffers(device: device)
      pipelineState = buildPipelineState(device: device)
    }

    init(device: MTLDevice, imageName: String, maskImageName: String) {
      super.init()
        buildVertices()
      buildBuffers(device: device)
      if let texture = setTexture(device: device, imageName: imageName) {
        self.texture = texture
        fragmentFunctionName = "textured_fragment"
      }
      if let maskTexture = setTexture(device: device,
                                      imageName: maskImageName) {
        self.maskTexture = maskTexture
        fragmentFunctionName = "textured_mask_fragment"
      }
      pipelineState = buildPipelineState(device: device)
    }
    func buildVertices () {}
    private func buildBuffers(device: MTLDevice) {
      vertexBuffer = device.makeBuffer(bytes: vertices,
                                       length: vertices.count *
                                        MemoryLayout<Vertex>.stride,
                                       options: [])
      indexBuffer = device.makeBuffer(bytes: indices,
                                      length: indices.count * MemoryLayout<UInt16>.size,
                                      options: [])
    }
  }
extension Primitive: Renderable {
    func doRender(commandEncoder: MTLRenderCommandEncoder, modelViewMatrix: matrix_float4x4) {
      guard let indexBuffer = indexBuffer else { return }
      
      let aspect = Float(750.0/1334.0)
      let projectionMatrix = matrix_float4x4(projectionFov: radians(fromDegrees: 65),
                                             aspect: aspect,
                                             nearZ: 0.1, farZ: 100)
      
      modelConstants.modelViewMatrix = matrix_multiply(projectionMatrix, modelViewMatrix)
        commandEncoder.setRenderPipelineState(pipelineState)
        commandEncoder.setVertexBuffer(vertexBuffer,
                                       offset: 0, index: 0)
        commandEncoder.setVertexBytes(&modelConstants,
                                      length: MemoryLayout<ModelConstants>.stride,
                                      index: 1)
        commandEncoder.setFragmentTexture(texture, index: 0)
        commandEncoder.setFragmentTexture(maskTexture, index: 1)
        commandEncoder.setFrontFacing(.counterClockwise)
        commandEncoder.setCullMode(.back)
        commandEncoder.drawIndexedPrimitives(type: .triangle,
                                           indexCount: indices.count,
                                           indexType: .uint16,
                                           indexBuffer: indexBuffer,
                                           indexBufferOffset: 0)
    }
}
extension Primitive: Texturable {
    
}
