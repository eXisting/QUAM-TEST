//
//  ActionsHeaderView.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/24/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class ActionsHeader: UICollectionReusableView {
  private let stackContainer = UIStackView()
  
  private let firstButton = UIButton()
  private let secondButton = UIButton()
  
  func setup() {
    laidOutViews()
    customizeViews()
  }
  
  private func laidOutViews() {
    addSubview(stackContainer)
    stackContainer.translatesAutoresizingMaskIntoConstraints = false
    stackContainer.pin(to: self)
    
    stackContainer.addArrangedSubview(firstButton)
    stackContainer.addArrangedSubview(secondButton)
  }
  
  private func customizeViews() {
    firstButton.backgroundColor = .lightGray
    secondButton.backgroundColor = .lightGray
    firstButton.setTitle("Posts", for: .normal)
    secondButton.setTitle("Dressing", for: .normal)
    
    stackContainer.distribution = .fillEqually
    stackContainer.axis = .horizontal
  }
}
