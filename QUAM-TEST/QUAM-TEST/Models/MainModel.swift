//
//  MainViewModel.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class MainModel: NSObject {
  private let requestManager = RequestManager()
  
  func loadImages() {
    requestManager.getListAsync(requestManager.rootEndpoint, for: Response.self) {
      list, error in
      
      print(list)
    }
  }
}

extension MainModel: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}
