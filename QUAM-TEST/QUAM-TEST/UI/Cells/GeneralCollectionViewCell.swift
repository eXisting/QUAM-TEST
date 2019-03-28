//
//  GeneralCollectionViewCell.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/23/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class GeneralCollectionViewCell: UICollectionViewCell {
  private let contentImage = UIImageView()
  private var spinner = UIActivityIndicatorView(style: .whiteLarge)
  private let userImageThumb = UIImageView()
  
  func initialize() {
    addSubview(spinner)
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.pin(to: self)
    spinner.color = .black
    
    addBackgroundView(contentImage)
    
    addSubview(userImageThumb)
    
    userImageThumb.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint(item: userImageThumb, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16).isActive = true
    NSLayoutConstraint(item: userImageThumb, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 16).isActive = true
    NSLayoutConstraint(item: userImageThumb, attribute: .height, relatedBy: .equal, toItem: userImageThumb, attribute: .width, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: userImageThumb, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.15, constant: 0).isActive = true
    
    toggleSpinner()
  }
  
  func setup(image: UIImage?) {
    contentImage.image = image
    userImageThumb.image = UIImage(named: "Header")
    userImageThumb.roundCorners(by: self.frame.height * 0.15 / 2)
    toggleSpinner()
  }
  
  private func toggleSpinner() {
    if spinner.isAnimating {
      spinner.stopAnimating()
      spinner.removeFromSuperview()
    } else {
      spinner.startAnimating()
    }
  }
}
