//
//  WordleMenuViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit
import MetalKit
import SwiftUI

class WordleMenuViewController: UIViewController {
var device: MTLDevice!
var commandQueue: MTLCommandQueue!
var renderer: Renderer?
private lazy var wordleMetalView: MTKView = {
    let wordleMetalView = MTKView(frame: CGRect(x: -10, y: 10, width: 200, height: 300))
    wordleMetalView.clearColor =  Constants.Colors.basicGrayMetal
    wordleMetalView.device = MTLCreateSystemDefaultDevice()
    guard let device = wordleMetalView.device else {
      fatalError("error")
    }
    renderer = Renderer(device: device)
    renderer?.scene = WordleGameScene(device: device, size: view.bounds.size)
    wordleMetalView.delegate = renderer
    return wordleMetalView
}()
private lazy var wordleButton: UIButton = {
   let wordleButton = ButtonModel(frame: CGRect(x: 185, y: 45, width: 170, height: 40))
    wordleButton.setTitle("Вордли", for: .normal)
    return wordleButton
}()
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.Colors.basicGray
    
    view.addSubview(wordleMetalView)
    view.addSubview(wordleButton)
    wordleButton.addTarget(self,
                     action: #selector(didTapQuizButton),
                     for: .touchUpInside)
}
@objc func didTapQuizButton() {
    let wordleVC = WordleViewController()
    navigationController?.pushViewController(wordleVC, animated: true)
}
}

