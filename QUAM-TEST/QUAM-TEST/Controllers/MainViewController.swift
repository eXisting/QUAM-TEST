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

extension MainViewController: UICollectionViewDelegate {
  
}
