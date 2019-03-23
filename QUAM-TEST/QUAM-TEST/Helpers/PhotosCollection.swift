//
//  PhotosCollection.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

enum PhotosJsonFields: String, CodingKey {
  case photos
  case photo
  
  case id
  case secret
  case server
  case farm
}

struct Response: Codable {
  var responseContainer: PhotosContainer
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: PhotosJsonFields.self)
    try container.encode(responseContainer, forKey: .photos)
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PhotosJsonFields.self)
    responseContainer = try container.decode(PhotosContainer.self, forKey: .photos)
  }
}

struct PhotosContainer: Codable {
  var photos: [Photo]
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: PhotosJsonFields.self)
    try container.encode(photos, forKey: .photo)
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PhotosJsonFields.self)
    photos = try container.decode([Photo].self, forKey: .photo)
  }
}

struct Photo: Codable {
  var id: String?
  var secret: String?
  var server: String?
  var farm: Int?
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: PhotosJsonFields.self)
    try container.encode(id!, forKey: .id)
    try container.encode(secret!, forKey: .secret)
    try container.encode(server!, forKey: .server)
    try container.encode(farm!, forKey: .farm)
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PhotosJsonFields.self)
    id = try? container.decode(String.self, forKey: .id)
    secret = try? container.decode(String.self, forKey: .secret)
    server = try? container.decode(String.self, forKey: .server)
    farm = try? container.decode(Int.self, forKey: .farm)
  }
}
