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
  @Published public private(set) var datas: [SearchDataViewModel] = []
  
  private let dataModel: DataModel = DataModel()
  private let artworkLoader: ArtworkLoader = ArtworkLoader()
  private var disposables = Set<AnyCancellable>()
  
  init() {
    $searchTerm
    //$searchType
          .sink(receiveValue: loadDatas(searchTerm:))
        .store(in: &disposables)
  }
  
    private func loadDatas(searchTerm: String /*, searchType: String*/) {
    datas.removeAll()
    artworkLoader.reset()
        print(searchType)
        dataModel.loadDatas(searchTerm: searchTerm, searchType: searchType ) { datas in
      datas.forEach { self.appendData(data: $0) }
    }
  }
  
  private func appendData(data: searchedData) {
    let dataViewModel = SearchDataViewModel(data: data)
    DispatchQueue.main.async {
      self.datas.append(dataViewModel)
    }
    
    artworkLoader.loadArtwork(forData: data) { image in
      DispatchQueue.main.async {
        dataViewModel.artwork100 = image
      }
    }
  }
}

class SearchDataViewModel: Identifiable, ObservableObject {
  let id: Int
  let collectionName: String?
  let collectionPrice: Float?
  let price: Float?
  let releaseDate: String?
  let trackName: String?
    let currency: String?
  @Published var artwork100: Image?
  
  init(data: searchedData) {
    self.id = data.id
    self.collectionName = data.collectionName
    self.collectionPrice = data.collectionPrice
      self.price = data.price
      self.releaseDate = data.releaseDate
      self.trackName = data.trackName
      self.currency = data.currency
  }
}

