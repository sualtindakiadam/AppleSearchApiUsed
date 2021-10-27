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
        
        VStack{
            Text(searchDataViewModel?.collectionName ?? searchDataViewModel?.trackName ?? "")
            BigArtworkView(image: searchDataViewModel?.artwork100)
            HStack{
                Text("\(String(searchDataViewModel?.collectionPrice ?? searchDataViewModel?.price ?? 0)) \(searchDataViewModel?.currency ?? "")")
                Spacer()
                Text(searchDataViewModel?.releaseDate?.prefix(10) ?? "")
                   
            }
            
         
            
        }
        .padding()
    }
}

 

struct BigArtworkView: View{
    
    let image: Image?

    var body: some View{
        VStack{
            if image != nil {
                image
            }else{
                Color(.systemIndigo)
          
            }
        }
        .frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.width-30 )
        .foregroundColor(.white)
        
    
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
