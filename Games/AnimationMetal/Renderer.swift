//
//  Renderer.swift
//  Games
//
//  Created by Мария Хатунцева on 26.06.2022.
//

import MetalKit

class Renderer: NSObject {
    var device: MTLDevice
    var commandQueue: MTLCommandQueue
    var scene: Scene?
    var samplerState: MTLSamplerState?
    var pipelineState: MTLRenderPipelineState?
    init(device: MTLDevice) {
        self.device = device
        commandQueue = device.makeCommandQueue()!
        super.init()
        buildSamplerState()
    }
    private func buildSamplerState() {
        let descriptor = MTLSamplerDescriptor()
        descriptor.minFilter = .linear
        descriptor.magFilter = .linear
        samplerState = device.makeSamplerState(descriptor: descriptor)
    }
}
extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
              let descriptor = view.currentRenderPassDescriptor else { return }
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        commandEncoder?.setFragmentSamplerState(samplerState, index: 0)
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        scene?.render(commandEncoder: commandEncoder!,
                      deltaTime: deltaTime)
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
