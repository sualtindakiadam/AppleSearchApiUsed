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
  
    func loadSongs(searchTerm: String,searchType: String, completion: @escaping(([searchedData]) -> Void)) {
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
      
      if let songResponse = try? JSONDecoder().decode(SongResponse.self, from: data) {
        completion(songResponse.songs)
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

struct SongResponse: Decodable {
  let songs: [searchedData]
  
  enum CodingKeys: String, CodingKey {
    case songs = "results"
  }
}

struct searchedData: Decodable {
  let id: Int
  let collectionName: String
  let collectionPrice: Float
  let releaseDate: String
  let artworkUrl: String
   /* let collectionPrice: String
    let collectionName: String
    let releaseDate: String*/
    
  
  enum CodingKeys: String, CodingKey {
    case id = "trackId"
    case collectionName
    case collectionPrice
    case releaseDate
    case artworkUrl = "artworkUrl100"
      /*case collectionPrice
      case collectionName
      case releaseDate*/
  }
}
