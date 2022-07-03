//
//  ViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 02.06.2022.
//

import UIKit
import MetalKit
import SwiftUI

class StartViewController: UIViewController {
    let quizMenuVC = QuizMenuViewController()
    let xoMenuVC = XOMenuViewController()
    let wordleMenuVC = WordleMenuViewController()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 70, y: 140, width: 250, height: 150))
        titleLabel.text = "ВО ЧТО ПОИГРАЕМ?!.."
        titleLabel.numberOfLines = 0
        titleLabel.textColor = Constants.Colors.basicOrange
        titleLabel.font = UIFont(name:"Avenir Next", size: 30)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.basicGray
        view.addSubview(titleLabel)
        addChildren()
        setupConstraints()
    }
    private func addChildren() {
        addChild(quizMenuVC)
        quizMenuVC.didMove(toParent: self)
        quizMenuVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizMenuVC.view)
        
        addChild(xoMenuVC)
        xoMenuVC.didMove(toParent: self)
        xoMenuVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(xoMenuVC.view)
        
        addChild(wordleMenuVC)
        wordleMenuVC.didMove(toParent: self)
        wordleMenuVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wordleMenuVC.view)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            quizMenuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizMenuVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizMenuVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            quizMenuVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),

            xoMenuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            xoMenuVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            xoMenuVC.view.topAnchor.constraint(equalTo: quizMenuVC.view.bottomAnchor),
            xoMenuVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            wordleMenuVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wordleMenuVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wordleMenuVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            wordleMenuVC.view.topAnchor.constraint(equalTo: xoMenuVC.view.bottomAnchor),
            xoMenuVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
    }
}

