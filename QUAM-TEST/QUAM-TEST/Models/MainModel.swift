//
//  MainViewModel.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

protocol ImageProcessing {
  func processImage(for cell: GeneralCollectionViewCell, with photoObject: Photo)
}

class MainModel {
  private let requestManager = RequestManager()
  private let cacheStorage = NSCache<AnyObject, AnyObject>()
  var dataSource: MainDataSource!
  
  init(delegate: UIScrollViewDelegate) {
    dataSource = MainDataSource(scrollDelegate: delegate, imageProcessDelegate: self)
  }
  
  func loadImages(_ completion: @escaping () -> Void) {
    requestManager.getAsync(requestManager.rootEndpoint, for: Response.self) {
      [weak self] object, error in
      guard let photosData = object?.responseContainer.photos else {
        print("Photos data is nil!")
        return
      }
      
      self?.initData(with: photosData)
      completion()
    }
  }
  
  private func initData(with photos: [Photo]) {
    dataSource.set(data: [TopSectionData(), GeneralSectionData(photos: photos)])
  }
}

//placeholders for images

extension MainModel: ImageProcessing {
  func processImage(for cell: GeneralCollectionViewCell, with photoObject: Photo) {    
    if let cachedImage = cacheStorage.object(forKey: photoObject.hash() as AnyObject) {
      DispatchQueue.main.async {
        cell.setup(image: (cachedImage as! UIImage))
        print("Cached image loaded for hash: \(photoObject.hash())")
      }
      
      return
    }
    
    let endpoint = requestManager.buildGetPhotoEndpoint(farmId: photoObject.farm, serverId: photoObject.server, id: photoObject.id, secret: photoObject.secret)
    
    requestManager.getDataAsync(from: endpoint) {
      [weak self] imageData in
      guard let data = imageData else {
        return
      }
      
      let image = UIImage(data: data)
      
      self?.cacheStorage.setObject(image!, forKey: photoObject.hash() as AnyObject)
      
      DispatchQueue.main.async {
        cell.setup(image: image)
      }
    }
  }
}
