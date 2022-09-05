//
//  QuizViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit
import MetalKit
import SwiftUI

class QuizViewController: UIViewController {
    @ObservedObject var navigation = Navigation()
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    var renderer: Renderer?
    var questions = [Question]()
    var labels: [UILabel] = []
    var wrongLabel = UILabel()
    var questionNumber = Int()
    var correctAnswerNumber = Int()
    var correctAnswers = 0
    var wrongAnswers = 0
    private lazy var metalView: MTKView = {
        let metalView = MTKView(frame: CGRect(x: 0, y: 0, width: 400, height: 700))
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
    private lazy var metalStackView: UIStackView = {
       let metalStackView = UIStackView(frame: CGRect(x: 0, y: 50, width: 400, height: 700))
        metalStackView.addSubview(metalView)
        return metalStackView
    }()
    private lazy var questionLabel: UILabel = {
        let questionLabel = UILabel(frame: CGRect(x: 50, y: 350, width: 300, height: 150))
        questionLabel.text = "Здесь будет задан какой-то вопрос? Надо выбрать ответ"
        questionLabel.textColor = Constants.Colors.basicOrange
        questionLabel.font = UIFont(name:"Avenir Next", size: 22)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        return questionLabel
    }()
    private lazy var buttonA: UIButton = {
        let buttonA = ButtonModel(frame: CGRect(x: 50, y: 500, width: 300, height: 40))
        return buttonA
    }()
    private lazy var buttonB: UIButton = {
        let buttonB = ButtonModel(frame: CGRect(x: 50, y: 550, width: 300, height: 40))
        return buttonB
    }()
    private lazy var buttonC: UIButton = {
        let buttonC = ButtonModel(frame: CGRect(x: 50, y: 600, width: 300, height: 40))
        return buttonC
    }()
    private lazy var buttonD: UIButton = {
        let buttonD = ButtonModel(frame: CGRect(x: 50, y: 650, width: 300, height: 40))
        return buttonD
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 400, height: 850))
        stackView.backgroundColor = Constants.Colors.lightSeaGreen
        stackView.addSubview(labelZero)
        stackView.addSubview(labelOne)
        stackView.addSubview(labelTwo)
        stackView.addSubview(labelThree)
        stackView.addSubview(labelFour)
        stackView.addSubview(labelFive)
        stackView.addSubview(labelSix)
        stackView.addSubview(labelSeven)
        stackView.addSubview(labelEight)
        stackView.addSubview(labelNine)
       return stackView
    }()
    private lazy var labelZero: UILabel = {
        let labelZero = LabelModel(frame: CGRect(x: 20, y: 110, width: 350, height: 30))
        labelZero.text = "Столица Камбоджи - Пномпень."
        return labelZero
    }()
    private lazy var labelOne: UILabel = {
        let labelOne = LabelModel(frame: CGRect(x: 20, y: 140, width: 350, height: 60))
        labelOne.text = "Кем был Чингисхан? - 1ый хан Монгольской империи."
        return labelOne
    }()
    private lazy var labelTwo: UILabel = {
        let labelTwo = LabelModel(frame: CGRect(x: 20, y: 200, width: 350, height: 60))
        labelTwo.text = "Где располагался пульт управления Карлсоном? - На животе."
        return labelTwo
    }()
    private lazy var labelThree: UILabel = {
        let labelThree = LabelModel(frame: CGRect(x: 20, y: 260, width: 350, height: 60))
        labelThree.text = "Корабль США, созданный для полёта на Луну. - Аполлон."
        return labelThree
    }()
    private lazy var labelFour: UILabel = {
        let labelFour = LabelModel(frame: CGRect(x: 20, y: 320, width: 350, height: 60))
        labelFour.text = "Сколько Республик объединяет ЕврАзЭс? - 5."
        return labelFour
    }()
    private lazy var labelFive: UILabel = {
        let labelFive = LabelModel(frame: CGRect(x: 20, y: 380, width: 350, height: 60))
        labelFive.text = "Именно этот философ проживал в бочке. Какой? - Диоген."
        return labelFive
    }()
    private lazy var labelSix: UILabel = {
        let labelSix = LabelModel(frame: CGRect(x: 20, y: 440, width: 350, height: 60))
        labelSix.text = "Назовите озеро, где было Ледовое побоище. - Чудское."
        return labelSix
    }()
    private lazy var labelSeven: UILabel = {
        let labelSeven = LabelModel(frame: CGRect(x: 20, y: 500, width: 350, height: 120))
        labelSeven.text = "Назовите слово, прародителем которого стал греческий аналог «неизданный». - Анекдот."
        return labelSeven
    }()
    private lazy var labelEight: UILabel = {
        let labelEight = LabelModel(frame: CGRect(x: 20, y: 620, width: 350, height: 30))
        labelEight.text = "Кто служил Д’Артаньяну? - Планше."
        return labelEight
    }()
    private lazy var labelNine: UILabel = {
        let labelNine = LabelModel(frame: CGRect(x: 20, y: 650, width: 350, height: 120))
        labelNine.text = "В грамматике этой страны все существительные должны писаться с большой буквы. Назовите страну. - Германия"
        return labelNine
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.basicGray
        view.addSubview(metalStackView)
        view.addSubview(buttonA)
        view.addSubview(buttonB)
        view.addSubview(buttonC)
        view.addSubview(buttonD)
        view.addSubview(questionLabel)
        questions = [
            Question(id: 0, question: "Столица Камбоджи", versions: ["Пхеньян", "Пномпень", "Пеньпнём", "Переяслав-Хмельницкий"], correctAnswer: 1),
            Question(id: 1, question: "Кем был Чингисхан?", versions: ["1ый хан Монгольской империи", "Потомок Китайской династии Тан", "Старшим наследником Тамерлана", "Тайным шпионом Японии"], correctAnswer: 0),
            Question(id: 2, question: "В каком месте располагался пульт управления Карлсоном?", versions: ["В желудке", "На лбу", "На животе", "На спине"], correctAnswer: 2),
            Question(id: 3, question: "Назовите, как именовали корабли США, созданные с целью полёта на Луну.", versions: ["Орион", "Луноход-2", "Джемини", "Аполлон"], correctAnswer: 3),
            Question(id: 4, question: "Сколько Республик объединяет ЕврАзЭс?", versions: ["5", "10", "15", "3"], correctAnswer: 0),
            Question(id: 5, question: "Именно этот философ проживал в бочке. Какой?", versions: ["Архимед", "Диоген", "Платон", "Демокрит"], correctAnswer: 1),
            Question(id: 6, question: "Назовите озеро, где было Ледовое побоище.", versions: ["Ильмень", "Онежское", "Ладожское", "Чудское"], correctAnswer: 3),
            Question(id: 7, question: "Назовите слово, прародителем которого стал греческий аналог «неизданный».", versions: ["Анекдот", "Мемуар", "Эссе", "Лирика"], correctAnswer: 0),
            Question(id: 8, question: "Кто служил Д’Артаньяну?", versions: ["Винтер", "Бонасье", "Планше", "Рошфор"], correctAnswer: 2),
            Question(id: 9, question: "В грамматике этой страны все существительные должны писаться с большой буквы. Назовите страну.", versions: ["Китай", "Руанда", "Венгрия", "Германия"], correctAnswer: 3),
        ]
        labels = [labelZero, labelOne, labelTwo, labelThree, labelFour, labelFive, labelSix, labelSeven, labelEight, labelNine]
        pickQuestion()
        buttonA.addTarget(self,
                         action: #selector(didTapAButton),
                        for: .touchUpInside)
        buttonB.addTarget(self,
                         action: #selector(didTapBButton),
                        for: .touchUpInside)
        buttonC.addTarget(self,
                         action: #selector(didTapCButton),
                        for: .touchUpInside)
        buttonD.addTarget(self,
                         action: #selector(didTapDButton),
                        for: .touchUpInside)
    }
    private func showAlertButtonTapped() {
        let alert = UIAlertController(title: "Квиз пройден! Ваш результат:", message: "Правильные ответы: \(correctAnswers); \n Неправильные ответы: \(wrongAnswers)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Посмотреть правильные ответы", style: UIAlertAction.Style.default, handler: { [self] action in
            self.view.addSubview(stackView)
        }))
        alert.addAction(UIAlertAction(title: "Попробовать еще раз", style: UIAlertAction.Style.cancel, handler: { action in
            self.navigation.navigateToVC(QuizViewController())
          }))
        alert.addAction(UIAlertAction(title: "В основное меню", style: UIAlertAction.Style.destructive, handler: { action in
            self.navigation.navigateToVC(StartViewController())
          }))
        self.present(alert, animated: true, completion: nil)
    }
    private func pickQuestion() {
        let buttons = [buttonA, buttonB, buttonC, buttonD]
        if questions.count > 0  {
            let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
            questionNumber = randomIndex
            let id = questions[questionNumber].id
            questionLabel.text = questions[questionNumber].question
            correctAnswerNumber = questions[questionNumber].correctAnswer
            wrongLabel = labels[id!]
            for i in 0..<buttons.count {
            buttons[i].setTitle(questions[questionNumber].versions[i], for: .normal)
            }
            questions.remove(at: questionNumber)
        } else {
            showAlertButtonTapped()
        }
    }
    @objc func didTapAButton() {
        if correctAnswerNumber == 0 {
            correctAnswers += 1
            pickQuestion()
        } else {
            wrongAnswers += 1
            wrongLabel.textColor = Constants.Colors.indianRed
            pickQuestion()
        }
    }
    @objc func didTapBButton() {
        if correctAnswerNumber == 1 {
            correctAnswers += 1
            pickQuestion()
        } else {
            wrongAnswers += 1
            wrongLabel.textColor = Constants.Colors.indianRed
            pickQuestion()
        }
    }
    @objc func didTapCButton() {
        if correctAnswerNumber == 2 {
            correctAnswers += 1
            pickQuestion()
        } else {
            wrongAnswers += 1
            wrongLabel.textColor = Constants.Colors.indianRed
            pickQuestion()
        }
    }
    @objc func didTapDButton() {
        if correctAnswerNumber == 3 {
            correctAnswers += 1
            pickQuestion()
        } else {
            wrongAnswers += 1
            wrongLabel.textColor = Constants.Colors.indianRed
            pickQuestion()
        }
    }
}
