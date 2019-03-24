//
//  ViewController.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  private let model = MainModel()
  private var mainView: MainViewContainer!
  
  override func loadView() {
    super.loadView()
    mainView = MainViewContainer(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.setup(delegate: self, dataSource: model)
    model.loadImages(reloadDataSource)
  }
  
  private func reloadDataSource() {
    DispatchQueue.main.async {
      self.mainView.reloadData()      
    }
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: CGFloat((collectionView.frame.size.width / 2) - 4), height: collectionView.frame.size.height / 5)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0 {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: CGFloat(collectionView.frame.size.width), height: model[section].height)
  }
}
