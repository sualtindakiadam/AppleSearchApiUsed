//
//  ContentView.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State var selected = 1
    var body: some View {
       
        VStack{
            SearchBar()
                      Picker(selection: $selected) {
                Text("1").tag(1)
                Text("2").tag(2)
            } label: {
                Text("Picker")
            }
            .pickerStyle(SegmentedPickerStyle())

          
            
            if selected == 1 {
                List(0..<5){ item in
                    Text("item")
                    
                }
            }else{
                List(0..<10){ item in
                    Text("item")
                    
                }
            }
               
        }
    }
}


struct LoadingStateView : View {
    var body: some View{
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .red))
            .scaleEffect(2)
        
    }
}


struct SearchBar: UIViewRepresentable {
  typealias UIViewType = UISearchBar
  
  //@Binding var searchTerm: String

  func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "Type a song, artist, or album name..."
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: Context) {
  }
  
  func makeCoordinator() -> SearchBarCoordinator {
    return SearchBarCoordinator(/*searchTerm: $searchTerm*/)
  }
  
  class SearchBarCoordinator: NSObject, UISearchBarDelegate {/*
    @Binding var searchTerm: String
    
    init(searchTerm: Binding<String>) {
      self._searchTerm = searchTerm
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchTerm = searchBar.text ?? ""
      UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
    }*/
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
