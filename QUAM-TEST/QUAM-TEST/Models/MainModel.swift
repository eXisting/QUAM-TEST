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
  
  subscript(section: Int) -> SectionHandling {
    return data[section]
  }
  
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
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MainViewContainer.generalCellIdentifier,
      for: indexPath) as? GeneralCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    guard let photoObject = data[indexPath.section][indexPath.row]?.photo else {
      return cell
    }
    
    let endpoint = requestManager.buildGetPhotoEndpoint(farmId: photoObject.farm, serverId: photoObject.server, id: photoObject.id, secret: photoObject.secret)
    
    requestManager.getDataAsync(from: endpoint) {
      imageData in
      guard let data = imageData else {
        return
      }
      
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        cell.setup(image: image)
      }
    }
    
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    if indexPath.section == 1 {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: MainViewContainer.actionHeaderIdentifier,
        for: indexPath) as? ActionsHeader else {
          fatalError("Returned class is not registered (ActionsHeader)")
      }
      
      headerView.setup()
      
      return headerView
    }
    
    guard let topHeader = collectionView.dequeueReusableSupplementaryView(
      ofKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: MainViewContainer.expandableHeaderIdentifier,
      for: indexPath) as? ExpandableHeader else {
        fatalError("Returned class is not registered (ExpandableHeader)")
    }
    
    return topHeader
  }
}
