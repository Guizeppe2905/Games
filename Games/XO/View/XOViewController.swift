//
//  XOViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit
import SwiftUI

class XOViewController: UIViewController {
    private lazy var aSV: UIStackView = {
       let aSV = UIStackView(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        return aSV
    }()
    private lazy var xoSV: UIStackView = {
       let xoSV = UIStackView(frame: CGRect(x: 0, y: 350, width: 350, height: 350))
        return xoSV
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren()
        view.addSubview(aSV)
        view.addSubview(xoSV)
    }
    private func addChildren() {
        let animationVC = AnimationViewController()
        let xoContentView = GameView()
        let xoCV = UIHostingController(rootView: xoContentView)
        addChild(xoCV)
        xoCV.didMove(toParent: self)
        xoCV.view.translatesAutoresizingMaskIntoConstraints = false
        xoSV.addSubview(xoCV.view)
        
        addChild(animationVC)
        animationVC.didMove(toParent: self)
        animationVC.view.translatesAutoresizingMaskIntoConstraints = false
        aSV.addSubview(animationVC.view)
    }
    private func setupConstraints() {
        let animationVC = AnimationViewController()
        let xoContentView = GameView()
        let xoCV = UIHostingController(rootView: xoContentView)
        NSLayoutConstraint.activate([
           animationVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           animationVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           animationVC.view.topAnchor.constraint(equalTo: view.topAnchor),
           animationVC.view.bottomAnchor.constraint(equalTo: xoCV.view.topAnchor),
           animationVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

           xoCV.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           xoCV.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           xoCV.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           xoCV.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
        ])
    }
}
