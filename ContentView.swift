//
//  ContentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm:BooksViewModel
    
    var body: some View {
        switch vm.screen {
        case .authentification:
            LoginView(userVM: UserViewModel())
        case .userHome:
            AppTabView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BooksViewModel())
    }
}
