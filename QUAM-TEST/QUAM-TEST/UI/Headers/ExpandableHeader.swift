//
//  ExpandableHeader.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/24/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class ExpandableHeader: UICollectionReusableView {
  private let scrollView = UIScrollView()
  let contentImage = UIImageView()
  let pageControl = UIPageControl()
  
  lazy var slides: [HeaderSlide] = {
    let initializedSlides = createSlides()
    setupSlideScrollView(slides: initializedSlides)
    return initializedSlides
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentImage.addBlur()
    laidOutViews()
    customizeViews()
    
    clipsToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(delegate: UIScrollViewDelegate) {
    pageControl.numberOfPages = slides.count
    pageControl.currentPage = 0
    pageControl.isUserInteractionEnabled = false
    scrollView.delegate = delegate
  }
  
  private func laidOutViews() {
    addBackgroundView(contentImage)
    contentImage.clipsToBounds = true
    
    addSubview(scrollView)
    addSubview(pageControl)
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.pin(to: self)
    
    NSLayoutConstraint(item: pageControl, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.55, constant: 0).isActive = true
    NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    
    bringSubviewToFront(pageControl)
  }
  
  private func customizeViews() {
    contentImage.image = UIImage(named: "Header")
    contentImage.contentMode = .redraw
    scrollView.showsHorizontalScrollIndicator = false
  }
  
  private func createSlides() -> [HeaderSlide] {
    let profileSlide = HeaderSlide()
    profileSlide.initializeWith(image: UIImage(named: "Header"), text: "Some username")
    
    let infoSlide = HeaderSlide()
    infoSlide.initializeWith(image: nil, text: "No description defined.\nNo address defined.\nNo site defined.")
    
    return [profileSlide, infoSlide]
  }
  
  
  private func setupSlideScrollView(slides: [HeaderSlide]) {
    scrollView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    scrollView.contentSize = CGSize(width: frame.width * CGFloat(slides.count), height: frame.height)
    scrollView.isPagingEnabled = true
    
    for i in 0 ..< slides.count {
      scrollView.addSubview(slides[i])
      slides[i].initialOrigin = CGPoint(x: 0, y: 0)
      slides[i].frame = CGRect(origin: slides[i].initialOrigin, size: CGSize(width: frame.width, height: frame.height))
      slides[i].setup()
    }
    
    slides[0].imageContent?.roundCorners(by: self.frame.height * 0.45 * 0.75 / 2)
    slides[1].textLabel?.transform = CGAffineTransform(scaleX: 0, y: 0)
    slides[1].textLabel?.alpha = 0
  }
}
