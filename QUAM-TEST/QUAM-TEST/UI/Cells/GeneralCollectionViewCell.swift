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
  
  private let userImageThumb = UIImageView()
  
  func setup(image: UIImage?) {
    addBackgroundView(contentImage)
    contentImage.image = image
    
    addSubview(userImageThumb)
    userImageThumb.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint(item: userImageThumb, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16).isActive = true
    NSLayoutConstraint(item: userImageThumb, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 16).isActive = true
    NSLayoutConstraint(item: userImageThumb, attribute: .height, relatedBy: .equal, toItem: userImageThumb, attribute: .width, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: userImageThumb, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.15, constant: 0).isActive = true

    userImageThumb.roundCorners(by: self.frame.height * 0.15 / 2)
    
    userImageThumb.image = UIImage(named: "Header")
  }
}
