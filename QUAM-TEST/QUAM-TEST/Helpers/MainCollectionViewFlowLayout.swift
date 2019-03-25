//
//  MainCollectionViewFlowLayout.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/25/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    guard let collectionView = collectionView else { return layoutAttributes }
    
    layoutAttributes?.forEach { attributes in
      if attributes.representedElementKind == UICollectionView.elementKindSectionHeader &&
        attributes.indexPath.section == 0 {
        
        let contentOffsetY = collectionView.contentOffset.y
        
        if contentOffsetY > 0 {
          return
        }
        
        let width = collectionView.frame.width
        let height = attributes.frame.height - contentOffsetY
        
        attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
      }     
    }
    
    return layoutAttributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
