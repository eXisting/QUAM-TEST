//
//  MainDataSource.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/28/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class MainDataSource: NSObject {
  private var data: [SectionHandling] = []
  private weak var scrollDelegate: UIScrollViewDelegate?
  private var imageProcessingDelegate: ImageProcessing?
  
  convenience init(scrollDelegate: UIScrollViewDelegate, imageProcessDelegate: ImageProcessing) {
    self.init()
    self.scrollDelegate = scrollDelegate
    self.imageProcessingDelegate = imageProcessDelegate
  }
  
  func set(data: [SectionHandling]) {
    self.data = data
  }
  
  subscript(section: Int) -> SectionHandling {
    return data[section]
  }
}

extension MainDataSource: UICollectionViewDataSource {
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
    
    guard let photoObject = data[indexPath.section][indexPath.row]?.photo else { return cell }
    
    imageProcessingDelegate?.processImage(for: cell, with: photoObject)
    cell.initialize()
    
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
    
    topHeader.setup(delegate: scrollDelegate!)
    
    return topHeader
  }
}

extension MainDataSource: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0 {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: CGFloat(collectionView.frame.size.width), height: data[section].height)
  }
}
