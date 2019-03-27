//
//  HeaderSlide.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/25/19.
//  Copyright © 2019 sys-246. All rights reserved.
//
import UIKit

class HeaderSlide: UIView {
  let container = UIStackView()
  
  var imageContent: UIImageView?
  var textLabel: UILabel?
  
  func initializeWith(image: UIImage?, text: String?) {
    if image != nil {
      imageContent = UIImageView()
    }
    
    if text != nil {
      textLabel = UILabel()
    }
    
    imageContent?.image = image
    textLabel?.text = text
  }
  
  func setup() {
    laidOutViews()
    customizeViews()
  }
  
  private func laidOutViews() {
    addSubview(container)
    container.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.45, constant: 0).isActive = true
    NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
    
    if let imageContent = imageContent {
      container.addArrangedSubview(imageContent)
      NSLayoutConstraint(item: imageContent, attribute: .width, relatedBy: .equal, toItem: imageContent, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    
    if let textLabel = textLabel {
      container.addArrangedSubview(textLabel)
      if imageContent != nil {
        NSLayoutConstraint(item: textLabel, attribute: .height, relatedBy: .equal, toItem: container, attribute: .height, multiplier: 0.25, constant: 0).isActive = true
      }
    }
  }
  
  private func customizeViews() {
    container.distribution = .fill
    container.alignment = .center
    container.axis = .vertical
    
    textLabel?.adjustsFontSizeToFitWidth = true
    textLabel?.textColor = .white
    textLabel?.textAlignment = .center
    textLabel?.numberOfLines = 3
  }
}
