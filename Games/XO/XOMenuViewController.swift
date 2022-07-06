//
//  XOMenuViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit
import MetalKit
import SwiftUI

class XOMenuViewController: UIViewController {
var device: MTLDevice!
var commandQueue: MTLCommandQueue!
var renderer: Renderer?
private lazy var xoMetalView: MTKView = {
    let xoMetalView = MTKView(frame: CGRect(x: 200, y: -20, width: 200, height: 300))
    xoMetalView.clearColor =  Constants.Colors.basicGrayMetal
    xoMetalView.device = MTLCreateSystemDefaultDevice()
    guard let device = xoMetalView.device else {
      fatalError("error")
    }
    renderer = Renderer(device: device)
    renderer?.scene = XOGameScene(device: device, size: view.bounds.size)
    xoMetalView.delegate = renderer
    return xoMetalView
}()
private lazy var xoButton: UIButton = {
    let xoButton = ButtonModel(frame: CGRect(x: 25, y: 40, width: 170, height: 40))
    xoButton.setTitle("Х vc 0", for: .normal)
    return xoButton
}()
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.Colors.basicGray
    view.addSubview(xoMetalView)
    view.addSubview(xoButton)
    xoButton.addTarget(self,
                     action: #selector(didTapXOButton),
                     for: .touchUpInside)
}
@objc func didTapXOButton() {
    let xoVC = XOViewController()
    navigationController?.pushViewController(xoVC, animated: true)
}
}

