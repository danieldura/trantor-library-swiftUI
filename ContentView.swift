//
//  ContentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var account:AccountObservableObject
    @EnvironmentObject var base:BaseObservableObject
    
    var body: some View {
        switch account.screen {
        case .authentification:
            LoginView()
        case .userHome:
            AppTabView().environmentObject(base)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BaseObservableObject())
    }
}
