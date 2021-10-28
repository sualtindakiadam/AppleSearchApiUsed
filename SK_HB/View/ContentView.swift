//
//  ContentView.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var searchDataListViewModel: SearchDataListViewModel

    var body: some View {
        NavigationView{
        VStack{
            SearchBar(searchTerm: $searchDataListViewModel.searchTerm, searchType: $searchDataListViewModel.searchType)
            SegmentedControlView(searchType: $searchDataListViewModel.searchType)
            
            if searchDataListViewModel.datas.isEmpty{
                EmptyModelView()
            }else{
                ListView(searchDataListViewModel: searchDataListViewModel)
                //ListPaginationThresholdExampleView(searchDataListViewModel: searchDataListViewModel)
                
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
        }
        
    }
}

struct ListView: View {
    @ObservedObject var searchDataListViewModel: SearchDataListViewModel
    var body: some View{
       
        VStack{
    
            Text("\(String(searchDataListViewModel.datas.count)) results found for you")
                .frame( height: 20)
                .font(.subheadline)
            
            List(searchDataListViewModel.datas){data in
                
                NavigationLink(destination: DetailsView(searchDataViewModel: data)) {
                    DataView(data: data)
                }
            }
        }
    }
}

/*

extension String: Identifiable {
    public var id: String {
        return self
    }
}

struct ListPaginationThresholdExampleView: View {
    @ObservedObject var searchDataListViewModel: SearchDataListViewModel

    
    
    //@State private var items: [String] = Array(0...24).map { "Item \($0)" }
    @State private var isLoading: Bool = false
    @State private var page: Int = 0
    
    private let pageSize: Int = 20
    private let offset: Int = 10
    
    var body: some View {
        NavigationView {
            List(searchDataListViewModel.datas) { data in
                VStack(alignment: .leading) {
                    //Text("asd")
                    
                    NavigationLink(destination: DetailsView(searchDataViewModel: data)) {
                        DataView(data: data)
                    }
                    
                    if self.isLoading && (data.id) == 0 {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)
                    }
                }.onAppear {
                    self.listItemAppears(data)
                }
            }
            .navigationBarHidden(true)
         
        }
    }
}

extension ListPaginationThresholdExampleView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if true {
            isLoading = true
            
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.page += 1
                //let moreItems = self.getMoreItems(forPage: self.page, pageSize: self.pageSize)
                //self.items.append(contentsOf: moreItems)
                
                self.isLoading = false
            }
        }
    }
}

*/

struct DataView: View{
    @ObservedObject var data: SearchDataViewModel
    var body: some View{
        HStack {
          ArtworkView(image: data.artwork100)
            .padding(.trailing)
          VStack(alignment: .leading) {
              
              Text((data.collectionName ?? data.trackName) ?? "")
              
              if let price = (data.collectionPrice ?? data.price ?? 0){
                  Text(price == 0.00 ?  "Free" : String(price))
              }
              
              //Text("\(String(data.collectionPrice ?? data.price ?? 0)) \(data.currency ?? "")")
              Text(data.releaseDate?.prefix(10) ?? "")
              .font(.footnote)
              .foregroundColor(.gray)
          }.padding()
        }
        .padding()
    }
}

struct ArtworkView: View{
    let image: Image?
    var body: some View{
        VStack{
            if image != nil {
                image
            }else{
                Color(.systemIndigo)
             
            }
        }
        .frame(width: 50, height: 50 )
        .foregroundColor(.white)
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
    @Binding var searchType: String
    

    var body: some View{
        Picker(selection: $searchType) {
            Text("Movies").tag("movie")
            Text("Music").tag("music")
            Text("Apps").tag("software")
            Text("Books").tag("ebook")
        } label: {
            Text("Picker")
        }
        .onChange(of: searchType, perform: { respose in
            print(searchType)
        })
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 9)
        
       
    }
}


struct SearchBar: UIViewRepresentable {
  typealias UIViewType = UISearchBar
  
  @Binding var searchTerm: String
    @Binding var searchType: String
    
  func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = "Type a movie, music, app or book name..."
    
    return searchBar
  }
  
  func updateUIView(_ uiView: UISearchBar, context: Context) {
  }
  
  func makeCoordinator() -> SearchBarCoordinator {
    return SearchBarCoordinator(searchTerm: $searchTerm, searchType: $searchType)
  }
  
  class SearchBarCoordinator: NSObject, UISearchBarDelegate {
    @Binding var searchTerm: String
    
    
      init(searchTerm: Binding<String>, searchType: Binding<String>) {
      self._searchTerm = searchTerm
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        if searchBar.text?.count ?? 0 > 1{
            searchTerm = searchBar.text ?? ""
    
        }
        
      
       
      UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
    }
        
  }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(searchDataListViewModel: SearchDataListViewModel())
    }
}

