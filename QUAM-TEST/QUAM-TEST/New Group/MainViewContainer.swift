//
//  MainViewContainer.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class MainViewContainer: UICollectionView {
  static let generalCellIdentifier = "GeneralCell"
  static let headerCellIdentifier = "HeaderCell"

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    
    register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: MainViewContainer.headerCellIdentifier)
    register(GeneralCollectionViewCell.self, forCellWithReuseIdentifier: MainViewContainer.generalCellIdentifier)

    backgroundColor = .white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
    self.delegate = delegate
    self.dataSource = dataSource
  }
}
