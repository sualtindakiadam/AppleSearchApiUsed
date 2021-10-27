//
//  DataModel.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

// https://itunes.apple.com/search?term=coldplay&entity=song


import Foundation
import SwiftUI

class DataModel {
  
  private var dataTask: URLSessionDataTask?
  
    func loadDatas(searchTerm: String,searchType: String, completion: @escaping(([searchedData]) -> Void)) {
    dataTask?.cancel()
        guard let url = buildUrl(forTerm: searchTerm, forMedia: searchType ) else {
      completion([])
      return
    }
    
    dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else {
        completion([])
        return
      }
      
      if let dataResponse = try? JSONDecoder().decode(DataResponse.self, from: data) {
        completion(dataResponse.datas)
      }
    }
    dataTask?.resume()
  }
  
    private func buildUrl(forTerm searchTerm: String, forMedia searctType:String) -> URL? {
    guard !searchTerm.isEmpty else { return nil }
    
    let queryItems = [
      URLQueryItem(name: "term", value: searchTerm),
      URLQueryItem(name: "media", value: searctType),
    ]
    var components = URLComponents(string: "https://itunes.apple.com/search")
    components?.queryItems = queryItems
      print("--------------------------------------------------------")
      print(components)
      print("--------------------------------------------------------")

    
    return components?.url
  }
}

struct DataResponse: Decodable {
  let datas: [searchedData]
  
  enum CodingKeys: String, CodingKey {
    case datas = "results"
  }
}

struct searchedData: Decodable {
  let id: Int
  let collectionName: String?
  let collectionPrice: Float?
  let price: Float?
  let releaseDate: String?
  let artworkUrl100: String
  let trackName: String?
    let currency: String?

    
  
  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case collectionName
    case collectionPrice
    case price
    case releaseDate
    case trackName
      case currency
    case artworkUrl100 = "artworkUrl100"
  

  }
}
