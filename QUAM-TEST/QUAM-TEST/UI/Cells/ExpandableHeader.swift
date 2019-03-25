//
//  ExpandableHeader.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/24/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class ExpandableHeader: UICollectionReusableView {
  private let contentImage = UIImageView()
  
  func setup() {
    addBackgroundView(contentImage)
    contentImage.image = UIImage(named: "Header")
  }
}
