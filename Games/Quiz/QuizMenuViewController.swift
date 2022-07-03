//
//  QuizMenuViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//
import UIKit
import MetalKit
import SwiftUI

class QuizMenuViewController: UIViewController {
var device: MTLDevice!
var commandQueue: MTLCommandQueue!
var renderer: Renderer?
private lazy var metalView: MTKView = {
    let metalView = MTKView(frame: CGRect(x: -10, y: 10, width: 200, height: 300))
    metalView.clearColor =  Constants.Colors.basicGrayMetal
    metalView.device = MTLCreateSystemDefaultDevice()
    guard let device = metalView.device else {
      fatalError("error")
    }
    renderer = Renderer(device: device)
    renderer?.scene = GameScene(device: device, size: view.bounds.size)
    metalView.delegate = renderer
    return metalView
}()
private lazy var quizButton: UIButton = {
   let quizButton = ButtonModel(frame: CGRect(x: 185, y: 60, width: 170, height: 40))
    quizButton.setTitle("Квиз!", for: .normal)
    return quizButton
}()
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.Colors.basicGray
    view.addSubview(metalView)
    view.addSubview(quizButton)
    quizButton.addTarget(self,
                     action: #selector(didTapQuizButton),
                     for: .touchUpInside)
}
@objc func didTapQuizButton() {
    let quizVC = QuizViewController()
    navigationController?.pushViewController(quizVC, animated: true)
}
}
