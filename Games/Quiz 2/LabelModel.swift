//
//  LabelModel.swift
//  Games
//
//  Created by Мария Хатунцева on 03.07.2022.
//

import UIKit

class LabelModel: UILabel {
  override init(frame: CGRect) {
      super.init(frame: frame)
      self.font = UIFont(name:"Avenir Next", size: 20)!
      self.textAlignment = .natural
      self.numberOfLines = 0
      self.textColor = Constants.Colors.forestGreen
      self.text = ""
  }
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
}
