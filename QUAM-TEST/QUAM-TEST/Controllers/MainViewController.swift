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
    mainView = MainViewContainer(frame: view.frame, collectionViewLayout: MainCollectionViewFlowLayout())
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.setup(delegate: self, dataSource: model)
    model.loadImages(reloadDataSource)
    model.scrollDelegate = self
  }
  
  private func reloadDataSource() {
    DispatchQueue.main.async {
      self.mainView.reloadData()      
    }
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
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
    return CGSize(width: CGFloat(collectionView.frame.size.width), height: model[section].height)
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

    // vertical
    let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
    let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

    let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
    let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

    let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)

    let maxOffset: CGFloat = 1
    if percentOffset.x > 0 && percentOffset.x <= maxOffset {
      parent.slides[1].textLabel?.transform = CGAffineTransform(scaleX: (maxOffset / 2 + percentOffset.x) / maxOffset, y: (maxOffset / 2 + percentOffset.x) / maxOffset)
    }
  }
}
