//
//  AnimationViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit
import MetalKit

class AnimationViewController: UIViewController {
  
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    
    var renderer: Renderer?
    private lazy var metalView: MTKView = {
        let metalView = MTKView(frame: CGRect(x: 0, y: 0, width: 400, height: 900))
        metalView.clearColor =  Constants.Colors.basicGrayMetal
        metalView.device = MTLCreateSystemDefaultDevice()
        guard let device = metalView.device else {
          fatalError("error")
        }
        renderer = Renderer(device: device)
        renderer?.scene = XOGameScene(device: device, size: view.bounds.size)
        metalView.delegate = renderer
        return metalView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(metalView)
       
    }
}
