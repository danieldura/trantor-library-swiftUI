//
//  AppTabView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import SwiftUI

struct AppTabView: View {
    @EnvironmentObject var store:BooksStoreObservableObject
    var body: some View {
        TabView {
            ListBooksView().environmentObject(store)
            .tabItem {
                Label("Books".localized, systemImage: "books.vertical")
            }
            ReadBooksListView().environmentObject(store)
                .badge("!")
            .tabItem{
                Label("Read".localized,systemImage: "star")
            }
            AccountView().environmentObject(store)
                .tabItem {
                    Label("Account".localized,systemImage: "person")
                }
        }
        .task {
            _ = await (store.fetchOrders())
            
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .environmentObject(BooksStoreObservableObject())
    }
}
