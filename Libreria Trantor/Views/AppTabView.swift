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
            NavigationStack {
                
            }
        }
        .tabItem {
            Label("Books".localized, systemImage: "atom")
        }
        NavigationStack {
            
        }
        .tabItem{
            Label("Favorites".localized,systemImage: "star")
        }
        
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
