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
                Label("Books".localized, systemImage: "books.vertical")
            }
            ReadBooksListView()
                .badge("!")
            .tabItem{
                Label("Read".localized,systemImage: "star")
            }
            AccountView()
                .tabItem {
                    Label("Account".localized,systemImage: "person")
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
