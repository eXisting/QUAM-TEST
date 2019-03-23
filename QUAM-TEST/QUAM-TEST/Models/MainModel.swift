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
  private var photos: [Photo] = []
  
  func loadImages(_ completion: @escaping () -> Void) {
    requestManager.getAsync(requestManager.rootEndpoint, for: Response.self) {
      [weak self] object, error in
      guard let photosData = object?.responseContainer.photos else {
        print("Photos data is nil!")
        return
      }
      
      self?.photos = photosData
      completion()
    }
  }
}

extension MainModel: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewContainer.generalCellIdentifier, for: indexPath)
    
    return cell
  }
}
