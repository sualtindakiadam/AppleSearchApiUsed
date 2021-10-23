//
//  ViewModel.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

import Combine
import Foundation
import SwiftUI

class SearchDataListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var searchType: String = ""
  @Published public private(set) var songs: [SearchDataViewModel] = []
  
  private let dataModel: DataModel = DataModel()
  private let artworkLoader: ArtworkLoader = ArtworkLoader()
  private var disposables = Set<AnyCancellable>()
  
  init() {
    $searchTerm
    //$searchType
          .sink(receiveValue: loadSongs(searchTerm:))
        .store(in: &disposables)
  }
  
    private func loadSongs(searchTerm: String /*, searchType: String*/) {
    songs.removeAll()
    artworkLoader.reset()
        print(searchType)
        dataModel.loadSongs(searchTerm: searchTerm, searchType: searchType ) { songs in
      songs.forEach { self.appendSong(song: $0) }
    }
  }
  
  private func appendSong(song: searchedData) {
    let songViewModel = SearchDataViewModel(song: song)
    DispatchQueue.main.async {
      self.songs.append(songViewModel)
    }
    
    artworkLoader.loadArtwork(forSong: song) { image in
      DispatchQueue.main.async {
        songViewModel.artwork = image
      }
    }
  }
}

class SearchDataViewModel: Identifiable, ObservableObject {
  let id: Int
  let trackName: String
  let artistName: String
  @Published var artwork: Image?
  
  init(song: searchedData) {
    self.id = song.id
    self.trackName = song.trackName
    self.artistName = song.artistName
  }
}

