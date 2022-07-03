//
//  LaunchViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 01.07.2022.
//

import UIKit

class LaunchViewController: UIViewController {
    private lazy var launchLabel: UILabel = {
        let launchLabel = UILabel(frame: CGRect(x: 30, y: 350, width: 350, height: 150))
        launchLabel.text = "Games"
        launchLabel.textAlignment = .center
        launchLabel.font = UIFont(name: "Chalkduster", size: 55)
        launchLabel.textColor = Constants.Colors.basicOrange
        return launchLabel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.basicGray
        view.addSubview(launchLabel)
    }
}
