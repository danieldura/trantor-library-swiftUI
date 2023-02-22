//
//  AppTabView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            ListBooksView()
            .tabItem {
                Label("Books".localized, systemImage: "atom")
            }
            FavoriteBooksListView()
                .badge("!")
            .tabItem{
                Label("Favorites".localized,systemImage: "star")
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(BooksViewModel())
    }
}
