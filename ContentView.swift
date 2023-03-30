//
//  ContentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var account:AccountObservableObject
    
    var body: some View {
        Group {
            switch account.screen {
            case .authentification:
                LoginView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .userHome:
                AppTabView()
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
                    .environmentObject(BooksStoreObservableObject())
            }
        }.animation(.default, value: account.screen)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BaseObservableObject())
    }
}
