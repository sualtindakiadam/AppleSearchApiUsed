//
//  DetailsView.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 23.10.2021.
//

import SwiftUI

struct DetailsView: View {
    
    var searchDataViewModel: SearchDataViewModel?
        
    var body: some View {
        
        HStack{
            ArtworkView(image: searchDataViewModel?.artwork100)
                .padding()
        VStack{
            Text(searchDataViewModel?.collectionName ?? searchDataViewModel?.trackName ?? "")
         
            HStack{
                Text("\(String(searchDataViewModel?.collectionPrice ?? searchDataViewModel?.price ?? 0)) \(searchDataViewModel?.currency ?? "")")
                Spacer()
                Text(searchDataViewModel?.releaseDate?.prefix(10) ?? "")
                   
            }
            
         
            
        }
        .frame(height: 50)
        .padding()
        }
        .padding()
    }
}

 



struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
