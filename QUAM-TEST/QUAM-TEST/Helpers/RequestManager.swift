//
//  RequestManager.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

class RequestManager {
  private let request = UrlSessionHandler.shared
  
  let rootEndpoint = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=78610c6fafbe6a423a77d31379f80bd2&format=json&per_page=10&nojsoncallback=1"
  
  // MARK: - GET
  
  func getListAsync<T: Decodable>(
    _ url: String,
    for type: T.Type,
    _ completion: @escaping ([T], ServerResponse) -> Void) {
    
    request.startSessionTask(url, params: nil) {
      (json, response) in
      let result = Parser.anyArrayToObjectArray(destination: T.self, json)
      completion(result, response)
    }
  }
  
  func getAsync<T: Decodable>(
    _ url: String,
    for type: T.Type,
    _ completion: @escaping (T?, ServerResponse) -> Void) {
    
    request.startSessionTask(url, params: nil) {
      (json, response) in
      guard let initableObject = Parser.anyToObject(destination: T.self, json) else {
        completion(nil, response)
        return
      }
      
      completion(initableObject, response)
    }
  }
  
  func getDataAsync(from url: String, _ completion: @escaping (Data?) -> Void) {
    guard let urlObject = URL(string: url) else {
      completion(nil)
      return
    }
    
    request.getData(from: urlObject, completion: completion)
  }
  
  func buildGetPhotoEndpoint(farmId: Int?, serverId: String?, id: String?, secret: String?) -> String {
    return "https://farm\(farmId ?? 8).staticflickr.com/\(serverId ?? "")/\(id ?? "")_\(secret ?? "").jpg"
  }
}

enum RequestType: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

struct ServerResponse: Codable {
  var error: String?
  
  init() {}
  
  init(_ error: String?) {
    self.error = error
  }
}

enum ResponseStatus: String {
  case success
  case invalidData = "Passed data is invalid!"
  case applicationError = "Applicaton error! Contact developer"
  
  case cannotProceed = "Server cannot proceed your request!"
  case serverError = "Server error!"
}

class UrlSessionHandler {
  
  static let shared = UrlSessionHandler()
  
  private let defaultSession = URLSession(configuration: .default)
  private let emptyJson: Parser.JsonDictionary = [:]
  
  private init() {}
  
  func startSessionTask(
    _ url: String,
    _ type: RequestType = .get,
    body: Parser.JsonDictionary? = nil,
    params: Parser.JsonDictionary? = nil,
    completion: @escaping (Any, ServerResponse) -> Void) {
    
    guard let urlRequest = buildUrlRequest(url, type.rawValue, params, body) else {
      completion(emptyJson, ServerResponse(ResponseStatus.cannotProceed.rawValue))
      return
    }
    
    let task = defaultSession.dataTask(with: urlRequest) { [weak self]
      (data, response, error) in
      if error != nil {
        completion(self!.emptyJson, ServerResponse(error?.localizedDescription))
        return
      }
      
      guard let jsonData = data else {
        completion(self!.emptyJson, ServerResponse(ResponseStatus.serverError.rawValue))
        return
      }
      
      guard let json = Serializer.encodeWithJsonSerializer(data: jsonData) else {
        completion(self!.emptyJson,  ServerResponse(ResponseStatus.serverError.rawValue))
        return
      }
            
      guard let serverError = Parser.anyToObject(destination: ServerResponse.self, json) else {
        completion(json, ServerResponse())
        return
      }
      
      completion(serverError.error ?? json, serverError)
    }
    
    task.resume()
  }
  
  func getData(from url: URL, completion: @escaping (Data?) -> ()) {
    defaultSession.dataTask(with: url) {
      (data, response, error) in
      if error != nil {
        completion(nil)
        return
      }
      
      guard let objectData = data else {
        completion(nil)
        return
      }
      
      completion(objectData)
      }.resume()
  }
}

// MARK: - HELPERS
private extension UrlSessionHandler {
  private func buildUrlRequest(
    _ url: String,
    _ method: String,
    _ params: Parser.JsonDictionary?,
    _ body: Parser.JsonDictionary? = nil) -> URLRequest? {
    
    var parameterString = ""
    
    if let parameters = params {
      parameterString = parameters.asParamsString()
    }
    
    guard let url = URL(string: url + parameterString) else {
      print("Error: cannot create URL")
      return nil
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    return request
  }
  
  static private func debugResponse(_ jsonData: Data) {
    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
      print(JSONString)
    }
  }
}
