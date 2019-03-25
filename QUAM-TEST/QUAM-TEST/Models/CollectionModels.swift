//
//  CollectionModels.swift
//  QUAM-TEST
//
//  Created by Andrey Popazov on 3/23/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

protocol SectionHandling {
  var numbersOfElements: Int { get }
  var height: CGFloat { get }
  subscript(rowIndex: Int) -> ElementData? { get }
}

struct TopSectionData: SectionHandling {
  subscript(rowIndex: Int) -> ElementData? {
    return nil
  }
  
  var height: CGFloat = 200
  
  var numbersOfElements: Int = 0
}

struct GeneralSectionData: SectionHandling {
  subscript(rowIndex: Int) -> ElementData? {
    return elements[rowIndex]
  }
  
  var height: CGFloat = 50
  
  var numbersOfElements: Int
  
  var elements: [ElementData] = []
  
  init(photos: [Photo]) {
    for photo in photos {
      elements.append(.init(photo))
    }
    
    numbersOfElements = elements.count
  }
}

struct ElementData {
  var photo: Photo
  
  var image: UIImage?
  
  init(_ photo: Photo) {
    self.photo = photo
  }
}
