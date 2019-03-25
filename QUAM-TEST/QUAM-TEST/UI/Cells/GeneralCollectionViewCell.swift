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
  
  func setup(image: UIImage?) {
    addBackgroundView(contentImage)
    contentImage.image = image
  }
}
