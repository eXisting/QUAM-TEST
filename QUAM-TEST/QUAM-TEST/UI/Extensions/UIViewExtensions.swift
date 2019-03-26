//
//  UIViewExtensions.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/26/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

extension UIView {
  func roundCorners(by cornerRadius: CGFloat){
    layer.cornerRadius = cornerRadius
    clipsToBounds = true
    backgroundColor = .clear
    tintColor = .white
    layer.borderWidth = 1
  }
  func addBackgroundView(_ view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false
    insertSubview(view, at: 0)
    view.pin(to: self)
  }

  func pin(to view: UIView) {
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topAnchor.constraint(equalTo: view.topAnchor),
      bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
  }
}

protocol Bluring {
  func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
  func addBlur(_ alpha: CGFloat = 0.5) {
    // create effect
    let effect = UIBlurEffect(style: .regular)
    let effectView = UIVisualEffectView(effect: effect)
    
    // set boundry and alpha
    effectView.frame = self.bounds
    effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    effectView.alpha = alpha
    
    self.addSubview(effectView)
  }
}

// Conformance
extension UIView: Bluring {}
