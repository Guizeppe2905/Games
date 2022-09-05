//
//  ButtonModel.swift
//  Games
//
//  Created by Мария Хатунцева on 30.06.2022.
//

import UIKit

class ButtonModel: UIButton {
  override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = Constants.Colors.basicOrange
      self.layer.cornerRadius = 20
      self.setTitleColor(Constants.Colors.basicGray, for: .normal)
      self.titleLabel?.numberOfLines = 0
      self.titleLabel?.textAlignment = .center
      self.titleLabel?.font = UIFont(name:"Avenir Next", size: 18)
      self.setTitle("", for: .normal)
  }
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
}
