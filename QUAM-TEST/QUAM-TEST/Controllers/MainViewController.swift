//
//  ViewController.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  private var model: MainModel!
  private var mainView: MainViewContainer!
  
  override func loadView() {
    super.loadView()
    mainView = MainViewContainer(frame: view.frame, collectionViewLayout: MainCollectionViewFlowLayout())
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    model = MainModel(delegate: self)
    mainView.setup(delegate: model.dataSource, dataSource: model.dataSource)
    model.loadImages(reloadDataSource)
  }
  
  private func reloadDataSource() {
    DispatchQueue.main.async {
      self.mainView.reloadData()      
    }
  }
}

extension MainViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let parent = scrollView.superview as? ExpandableHeader else {
      return
    }
    
    let pageIndex = round(scrollView.contentOffset.x / mainView.frame.width)
    parent.pageControl.currentPage = Int(pageIndex)

    let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
    let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

    let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
    
    parent.slides[1].frame.origin = CGPoint(x: parent.slides[1].initialOrigin.x + currentHorizontalOffset, y: 0)
    parent.slides[1].textLabel?.transform = CGAffineTransform(scaleX: percentageHorizontalOffset, y: percentageHorizontalOffset)
    parent.slides[1].textLabel?.alpha = percentageHorizontalOffset
  }
}
