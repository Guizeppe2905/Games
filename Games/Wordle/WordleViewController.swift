//
//  WordleViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit
import SwiftUI

class WordleViewController: UIViewController {
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    let navigation = Navigation()
    let answers = ["почта", "лодка", "кошка", "рюмка", "вилка", "ложка", "повод", "полка", "дождь", "дуэль", "магия", "прием", "вклад", "анонс", "архив", "лесть", "длина", "стена", "плато", "декор", "топор", "собор", "дупло", "грудь", "опрос", "арбуз", "бокал", "пенал", "сюжет", "идеал", "шутка", "штука", "веник", "бровь", "школа", "мечта", "гонка", "русло", "халва", "совет", "салон", "кокос", "пицца", "адрес", "кешью", "выезд", "верба", "стиль", "сосна", "отказ", "берег", "радар", "пламя", "орган", "сетка", "фраза", "кровь", "гольф", "астра", "донка", "клоун", "спорт", "валет", "секта", "трава", "туман", "ручка", "жизнь", "пьеса", "чугун", "осень", "набор", "хурма", "тропа", "нефть", "весна", "ферзь", "ссора", "арена", "глист", "пятка", "налог", "оклад", "почка", "балет", "родня"]
    var answer = ""
    var numberOfCorrectLetters = 0
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 8)
    private let buttonAgain: UIButton = {
        let buttonAgain = UIButton(frame: CGRect(x: 238, y: 610, width: 60, height: 60))
        buttonAgain.setTitle("Заново", for: .normal)
        buttonAgain.backgroundColor = .systemIndigo
        buttonAgain.layer.cornerRadius = buttonAgain.frame.width / 2
        buttonAgain.titleLabel?.textAlignment = .center
        buttonAgain.setTitleColor(.white, for: .normal)
        buttonAgain.titleLabel?.font = UIFont(name:"Avenir Next", size: 14)
        return buttonAgain
    }()
    private let buttonRules: UIButton = {
        let buttonRules = UIButton(frame: CGRect(x: 168, y: 610, width: 60, height: 60))
        buttonRules.setTitle("Правила", for: .normal)
        buttonRules.backgroundColor = .systemPink
        buttonRules.layer.cornerRadius = buttonRules.frame.width / 2
        buttonRules.titleLabel?.textAlignment = .center
        buttonRules.setTitleColor(.white, for: .normal)
        buttonRules.titleLabel?.font = UIFont(name:"Avenir Next", size: 14)
        return buttonRules
    }()
    private let buttonBack: UIButton = {
        let buttonRules = UIButton(frame: CGRect(x: 98, y: 610, width: 60, height: 60))
        buttonRules.setTitle("Назад", for: .normal)
        buttonRules.backgroundColor = .systemMint
        buttonRules.layer.cornerRadius = buttonRules.frame.width / 2
        buttonRules.titleLabel?.textAlignment = .center
        buttonRules.setTitleColor(.white, for: .normal)
        buttonRules.titleLabel?.font = UIFont(name:"Avenir Next", size: 14)
        return buttonRules
    }()
    private lazy var descriptionLabel: UILabel = {
       let descriptionLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 320, height: 500))
        descriptionLabel.text = "Отгадайте слово из 5 букв. После каждой попытки буквы заполненной строки приобретают цвет: \n - красный, если такой буквы в загаданном слове нет; \n - оранжевый, если такая буква есть, но расположена в другом месте в загаданном слове; \n - зеленый, если такая буква есть и стоит она на правильном месте в загаданном слове."
        descriptionLabel.font = UIFont(name:"Avenir Next", size: 22)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .natural
        descriptionLabel.textColor = Constants.Colors.basicGray
        return descriptionLabel
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 20, y: 93, width: 345, height: 515))
        stackView.layer.cornerRadius = 20
        stackView.backgroundColor = Constants.Colors.lightSeaGreen
        stackView.addSubview(descriptionLabel)
        stackView.alpha = 0
       return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        answer = answers.randomElement() ?? "почта"
        view.backgroundColor = .systemGray6
        addChildren()
        view.addSubview(buttonAgain)
        view.addSubview(buttonRules)
        view.addSubview(buttonBack)
        view.addSubview(stackView)
        buttonAgain.addTarget(self,
                         action: #selector(didTapAgainButton),
                        for: .touchUpInside)
        buttonRules.addTarget(self,
                          action: #selector(didTapRulesButton),
                         for: .touchUpInside)
        buttonBack.addTarget(self,
                          action: #selector(didTapBackButton),
                         for: .touchUpInside)
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeRules)))
    }
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.datasource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
        setupConstraints()
    }
    @objc func didTapAgainButton() {
           navigation.navigateToVC(WordleViewController())
        }
    @objc func didTapRulesButton() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self = self else { return }
                    self.stackView.alpha = 1
        })
    }
    @objc func didTapBackButton() {
        navigation.navigateToVC(StartViewController())
    }
    @objc func closeRules() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self = self else { return }
                    self.stackView.alpha = 0
        })
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension WordleViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        boardVC.reloadData()
    }
}
extension WordleViewController: BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
            return guesses
    }
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 5 else {
            return nil
        }
        let indexedAnswer = Array(answer)
        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else {
            return Constants.Colors.indianRed
        }
        if indexedAnswer[indexPath.row] == letter {
            return Constants.Colors.forestGreen
        }
        return Constants.Colors.basicOrange
    }
}

