//
//  JsonSerializer.swift
//  QUAM-TEST
//
//  Created by sys-246 on 3/22/19.
//  Copyright © 2019 sys-246. All rights reserved.
//

import UIKit

enum UserMessage: String {
  case accountModeration = "Your account is under moderation!"
}

class Serializer {
  
  private static let decoder = JSONDecoder()
  private static let encoder = JSONEncoder()
  
  class func decodeDataInto<T: Decodable>(type: T.Type, _ data: Data) -> T? {
    return try? decoder.decode(type, from: data)
  }
  
  class func encodeDataFrom<T: Encodable>(object: T) -> Data? {
    return try? encoder.encode(object)
  }
  
  class func getDataFrom(json: Any) -> Data? {
    if (!JSONSerialization.isValidJSONObject(json)) {
      print("getDataFrom throws")
      return nil
    }
    
    return try? JSONSerialization.data(withJSONObject: json)
  }
  
  class func encodeWithJsonSerializer(data: Data) -> Any? {
    return try? JSONSerialization.jsonObject(with: data, options: [])
  }
}

class Parser {
  typealias JsonDictionary = [String:String]
  
  class func anyArrayToObjectArray<DestinationType: Decodable>(destination: DestinationType.Type, _ data: Any) -> [DestinationType] {
    var result = [DestinationType]()
    
    guard let elementsList = data as? [Any] else {
      print("Cannot cast to [Any] in anyToObjectArray")
      print(data)
      return []
    }
    
    for element in elementsList {
      guard let destinationObject = anyToObject(destination: DestinationType.self, element) else {
        continue
      }
      
      result.append(destinationObject)
    }
    
    return result
  }
  
  class func anyToObject<DestinationType: Decodable>(destination: DestinationType.Type, _ object: Any) -> DestinationType? {
    guard let data = Serializer.getDataFrom(json: object) else {
      return nil
    }
    
    guard let result = Serializer.decodeDataInto(type: DestinationType.self, data) else {
      return nil
    }
    
    return result
  }
}

extension Dictionary where Key == String, Value == String {
  
  // Shortcut for parsing dictionary as params string
  
  func asParamsString() -> String {
    return "?\(self.asDataString())"
  }
  
  func asDataString() -> String {
    let parameterArray = map { key, value -> String in
      let percentEscapedKey = key.addingPercentEncodingForURLQueryValue()!
      let percentEscapedValue = value.addingPercentEncodingForURLQueryValue()!
      return "\(percentEscapedKey)=\(percentEscapedValue)"
    }
    
    return parameterArray.joined(separator: "&")
  }
}

extension String {
  
  /// Percent escapes values to be added to a URL query as specified in RFC 3986
  ///
  /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
  ///
  /// http://www.ietf.org/rfc/rfc3986.txt
  ///
  /// - returns: Returns percent-escaped string.
  
  func addingPercentEncodingForURLQueryValue() -> String? {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="
    
    var allowed = CharacterSet.urlQueryAllowed
    allowed.remove(charactersIn: generalDelimitersToEncode + subDelimitersToEncode)
    
    return addingPercentEncoding(withAllowedCharacters: allowed)
  }
  
}
