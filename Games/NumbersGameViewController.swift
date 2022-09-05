//
//  NumbersGameViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 05.09.2022.
//

import UIKit
import Combine

class NumbersGameViewController: UIViewController {
    
    let navigation = Navigation()
    
    private var randomInt: Int = Int.random(in: 0..<100)
    var subscription: AnyCancellable? = nil
    private var tempText: String = ""
    private var timer = Timer()
    private var counter = 0
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "цыйрыбэк.png")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
   }()
    
    private lazy var guessLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Угадайте число от 1 до 100"
        label.textAlignment = .center
        label.textColor = .green
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.green.cgColor
        return label
    }()
    
    private lazy var numberTextField: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "0"
        textView.layer.borderColor = UIColor.green.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.textAlignment = .center
        textView.font = UIFont(name: "Arial", size: 18)
        textView.backgroundColor = .black
        textView.textColor = .green
        textView.contentInset = UIEdgeInsets(top: 7, left: 3, bottom: 0, right: 2)
        textView.becomeFirstResponder()
        return textView
    }()
    
    private lazy var hintLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .green
        label.layer.backgroundColor = UIColor.black.cgColor
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.green.cgColor
        label.alpha = 0
        return label
    }()
    
    private lazy var checkButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.setTitle("Проверить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.setTitle("Заново", for: .normal)
        button.setTitleColor(.green, for: .normal)
        return button
    }()
    
    private lazy var menuButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.green.cgColor
        button.setTitle("Назад в меню", for: .normal)
        button.setTitleColor(.green, for: .normal)
        return button
    }()
    
    private lazy var timerLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .green
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(guessLabel)
        view.addSubview(numberTextField)
        view.addSubview(hintLabel)
        view.addSubview(checkButton)
        view.addSubview(resetButton)
        view.addSubview(timerLabel)
        view.addSubview(menuButton)
        setConstraints()
      
        checkButton.addTarget(self,
                              action: #selector(didTapCheckButton),
                              for: .touchUpInside)
        resetButton.addTarget(self,
                              action: #selector(didTapResetButton),
                              for: .touchUpInside)
        menuButton.addTarget(self,
                              action: #selector(didTapMenuButton),
                              for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setSubscriber()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    private func setSubscriber(){
        subscription = NotificationCenter.default
            .publisher(for: UITextView.textDidChangeNotification, object: numberTextField)
            .compactMap { $0.object as? UITextView }
            .compactMap { $0.text }
            .sink {
                print($0)
                if self.randomInt > Int($0) ?? 0 {
                self.tempText = "Подсказка: Загаданное число больше"
                } else if self.randomInt < Int($0) ?? 0  {
                    self.tempText = "Подсказка: Загаданное число меньше"
                } else if self.randomInt == Int($0) ?? 0  {
                    self.tempText = "Урааа!!! Вы угадали!!! Ответ: \($0)"
                    self.subscription?.cancel()
                    self.timer.invalidate()
                }
    }
    }
    @objc private func didTapCheckButton() {
    
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }
            self.hintLabel.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            self.checkButton.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            self.hintLabel.alpha = 1
            self.hintLabel.text = self.tempText
            self.hintLabel.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            self.checkButton.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            
        }
       
    }
    @objc private func didTapResetButton() {
        navigation.navigateToVC(NumbersGameViewController())
    }
    @objc private func didTapMenuButton() {
        navigation.navigateToVC(StartViewController())
    }
    @objc private func timerAction(){
        counter += 1
        timerLabel.text = "Прошло \(counter) секунд"
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            
            guessLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            guessLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            guessLabel.widthAnchor.constraint(equalToConstant: 230),
            guessLabel.heightAnchor.constraint(equalToConstant: 50),

            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            numberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            numberTextField.widthAnchor.constraint(equalToConstant: 50),
            numberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            hintLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hintLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 310),
            hintLabel.widthAnchor.constraint(equalToConstant: 350),
            hintLabel.heightAnchor.constraint(equalToConstant: 50),
            
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            checkButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            checkButton.widthAnchor.constraint(equalToConstant: 140),
            checkButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            resetButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 140),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerLabel.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 120),
            timerLabel.widthAnchor.constraint(equalToConstant: 240),
            timerLabel.heightAnchor.constraint(equalToConstant: 70),
            
            menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            menuButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 20),
            menuButton.widthAnchor.constraint(equalToConstant: 140),
            menuButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}



