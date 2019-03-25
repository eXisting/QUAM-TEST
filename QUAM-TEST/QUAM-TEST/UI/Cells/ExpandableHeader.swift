//
//  ExpandableHeader.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/24/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class ExpandableHeader: UICollectionReusableView {
  private let contentImage = UIImageView()
  
  private let scrollView = UIScrollView()
  private let pageControl = UIPageControl()
  
  private var slides: [HeaderSlide] = []
    
  func setup() {
    laidOutViews()
    customizeViews()
    
    slides = createSlides()
    setupSlideScrollView(slides: slides)
    
    pageControl.numberOfPages = slides.count
    pageControl.currentPage = 0
  }
  
  private func laidOutViews() {
    addBackgroundView(contentImage)
    addSubview(scrollView)
    addSubview(pageControl)
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.pin(to: self)
    
    NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 0.95, constant: 0).isActive = true

    bringSubviewToFront(pageControl)
  }
  
  private func customizeViews() {
    contentImage.image = UIImage(named: "Header")
    contentImage.contentMode = .scaleAspectFill
  }
  
  private func createSlides() -> [HeaderSlide] {
    let profileSlide = HeaderSlide()
    profileSlide.setup(image: UIImage(named: "Header"), text: "Some username")
    
    let infoSlide = HeaderSlide()
    infoSlide.setup(image: nil, text: "No description defined.\nNo address defined.\nNo site defined.")
    
    return [profileSlide, infoSlide]
  }
  
  
  private func setupSlideScrollView(slides: [HeaderSlide]) {
    scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    scrollView.contentSize = CGSize(width: frame.width * CGFloat(slides.count), height: frame.height)
    scrollView.isPagingEnabled = true
    
    for i in 0 ..< slides.count {
      slides[i].frame = CGRect(x: frame.width * CGFloat(i), y: 0, width: frame.width, height: frame.height)
      scrollView.addSubview(slides[i])
    }
  }
}
