//
//  KeyboardViewController.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit

protocol KeyboardViewControllerDelegate: AnyObject {
    func keyboardViewController (_ vc: KeyboardViewController, didTapKey letter: Character)
}
class KeyboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    weak var delegate: KeyboardViewControllerDelegate?
    weak var datasource: BoardViewControllerDataSource?
    let letters = ["йцукенгшщзхъ", "фывапролджэё", "ячсмитьбю"]
    private var keys: [[Character]] = []
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Constants.Colors.basicGray
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = Constants.Colors.basicGray
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    public func reloadData() {
        collectionView.reloadData()
     }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
    }
}
extension KeyboardViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as?  KeyCell else {
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.row]
        cell.configure(with: letter)
        
     //   cell.backgroundColor = datasource?.boxColor(at: indexPath)
 //       if datasource?.currentGuesses == nil {
  //          cell.backgroundColor = Constants.Colors.basicGray
  //      } else if datasource?.boxColor(at: indexPath) == Constants.Colors.indianRed {
   //         cell.backgroundColor = Constants.Colors.indianRed
    //    } else if datasource?.boxColor(at: indexPath) == Constants.Colors.forestGreen {
     //       cell.backgroundColor = Constants.Colors.forestGreen
      //  } else {
       //     cell.backgroundColor = Constants.Colors.basicGray
        //}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width - margin) / 13
        return CGSize(width: size, height: size * 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var left: CGFloat = 1
        var right: CGFloat = 1
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width - margin) / 13
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))
        let inset: CGFloat = (collectionView.frame.size.width - (size * count) - (2 * count)) / 2
        left = inset
        right = inset
        return UIEdgeInsets(top: 2, left: left, bottom: 2, right: right)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.row]
        delegate?.keyboardViewController(self, didTapKey: letter)
        
    }
}
