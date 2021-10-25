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
        Text(searchDataViewModel?.collectionName ?? "asd")
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
