//
//  SK_HBApp.swift
//  SK_HB
//
//  Created by Semih Kalaycı on 21.10.2021.
//

import SwiftUI

@main
struct SK_HBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SongListViewModel())
        }
    }
}
