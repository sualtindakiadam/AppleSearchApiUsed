//
//  ContentView.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: SongListViewModel
   
    var body: some View {
       
        VStack{
            SearchBar(searchTerm: $viewModel.searchTerm)
            SegmentedControlView()
            
            if viewModel.songs.isEmpty{
                EmptyModelView()
            }else{
                
                List(viewModel.songs){song in
                    SongView(song: song)
                    
                }
                .listStyle(PlainListStyle())

              
                
               /* if selected == 1 {
                    List(0..<5){ item in
                        Text("item")
                        
                    }
                }else{
                    List(0..<10){ item in
                        Text("item")
                        
                    }
                }*/
                
            }
            
            
       
               
        }
    }
}

struct EmptyModelView: View{
    var body: some View {
     

            Spacer()
        Text("What do you want me to find for you ?")
            .font(.caption)
            Spacer()


    }
}

struct SegmentedControlView: View{
    @State var selected = 1
    var body: some View{
        Picker(selection: $selected) {
            Text("Movies").tag(1)
            Text("Music").tag(2)
            Text("Apps").tag(3)
            Text("Books").tag(4)
        } label: {
            Text("Picker")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 9)
    }
}

struct SongView: View{
    @ObservedObject var song: SongViewModel
    var body: some View{
        HStack {
          ArtworkView(image: song.artwork)
            .padding(.trailing)
          VStack(alignment: .leading) {
            Text(song.trackName)
            Text(song.artistName)
              .font(.footnote)
              .foregroundColor(.gray)
          }
        }
        .padding()
    }
}

struct ArtworkView: View{
    let image: Image?
    var body: some View{
        ZStack{
            if image != nil {
                image
            }else{
                Color(.systemIndigo)
                Image(systemName: "music.note")
                    .font(.largeTitle)
                    .shadow(radius: 5)
                    .padding(.trailing, 5)
            }
        }
        .frame(width: 50, height: 50 )
        .foregroundColor(.white)
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
  
  @Binding var searchTerm: String

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
    return SearchBarCoordinator(searchTerm: $searchTerm)
  }
  
  class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    @Binding var searchTerm: String
    
    init(searchTerm: Binding<String>) {
      self._searchTerm = searchTerm
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchTerm = searchBar.text ?? ""
      UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SongListViewModel())
    }
}
