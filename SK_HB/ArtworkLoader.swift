//
//  ArtworkLoader.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

import Foundation
import SwiftUI

class ArtworkLoader {
  private var dataTasks: [URLSessionDataTask] = []
  
  func loadArtwork(forData song: searchedData, completion: @escaping((Image?) -> Void)) {
    guard let imageUrl = URL(string: song.artworkUrl100) else {
      completion(nil)
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
      guard let data = data, let artwork = UIImage(data: data) else {
        completion(nil)
        return
      }
      
      let image = Image(uiImage: artwork)
      completion(image)
    }
    dataTasks.append(dataTask)
    dataTask.resume()
  }

  func reset() {
    dataTasks.forEach { $0.cancel() }
    dataTasks.removeAll()
  }
}
