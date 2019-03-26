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
    guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
    
    // Helpers
    let sectionsToAdd = NSMutableIndexSet()
    var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for layoutAttributesSet in layoutAttributes {
      if layoutAttributesSet.representedElementCategory == .cell {
        // Add Layout Attributes
        newLayoutAttributes.append(layoutAttributesSet)
        
        // Update Sections to Add
        sectionsToAdd.add(layoutAttributesSet.indexPath.section)
        
      } else if layoutAttributesSet.representedElementCategory == .supplementaryView {
        // Update Sections to Add
        sectionsToAdd.add(layoutAttributesSet.indexPath.section)
      }
    }
    
    for section in sectionsToAdd {
      let indexPath = IndexPath(item: 0, section: section)
      
      if let sectionAttributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
        newLayoutAttributes.append(sectionAttributes)
      }
    }
    
    return newLayoutAttributes
  }
  
  override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let layoutAttributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) else { return nil }
    guard let boundaries = boundaries(forSection: indexPath.section) else { return layoutAttributes }
    guard let collectionView = collectionView else { return layoutAttributes }
    
    let contentOffsetY = collectionView.contentOffset.y
    
    // if it is first section and it user scrolls to bottom
    if contentOffsetY > 0 && layoutAttributes.indexPath.section == 0 {
      return layoutAttributes
    }
    
    var frameForSupplementaryView = layoutAttributes.frame
    
    let minimum = boundaries.minimum - frameForSupplementaryView.height
    let maximum = boundaries.maximum - frameForSupplementaryView.height
    
    if contentOffsetY < minimum {
      frameForSupplementaryView.origin.y = minimum
    } else if contentOffsetY > maximum {
      frameForSupplementaryView.origin.y = maximum
    } else {
      frameForSupplementaryView.origin.y = contentOffsetY
    }
    
    let width = collectionView.frame.width
    let height = layoutAttributes.frame.height - contentOffsetY
    
    layoutAttributes.frame = layoutAttributes.indexPath.section == 0 ?
      CGRect(x: 0, y: contentOffsetY, width: width, height: height) : frameForSupplementaryView
    
    return layoutAttributes
  }
  
  override var itemSize: CGSize {
    get  {
      return CGSize(width: (collectionView!.frame.size.width / 2) - 3, height: (collectionView!.frame.size.height / 2.5))
    }
    set {
      super.itemSize = newValue
    }
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
    var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
    
    guard let collectionView = collectionView else { return result }
    
    let numberOfItems = collectionView.numberOfItems(inSection: section)
    
    guard numberOfItems > 0 else { return result }
    
    if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
      let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
      result.minimum = firstItem.frame.minY
      result.maximum = lastItem.frame.maxY
      
      result.minimum -= headerReferenceSize.height
      result.maximum -= headerReferenceSize.height
      
      result.minimum -= sectionInset.top
      result.maximum += (sectionInset.top + sectionInset.bottom)
    }
    
    return result
  }
}
