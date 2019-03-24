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
  private var data: [SectionHandling] = []
  
  func loadImages(_ completion: @escaping () -> Void) {
    requestManager.getAsync(requestManager.rootEndpoint, for: Response.self) {
      [weak self] object, error in
      guard let photosData = object?.responseContainer.photos else {
        print("Photos data is nil!")
        return
      }
      
      self?.initData(with: photosData)
      completion()
    }
  }
  
  private func initData(with photos: [Photo]) {
    data = [
      TopSectionData(),
      GeneralSectionData(photos: photos)
    ]
  }
}

extension MainModel: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data[section].numbersOfElements
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewContainer.generalCellIdentifier, for: indexPath) as? GeneralCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    cell.setup(image: UIImage(named: "Header")!)
    
    return cell
  }
}
