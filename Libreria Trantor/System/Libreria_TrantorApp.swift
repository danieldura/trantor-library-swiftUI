//
//  Libreria_TrantorApp.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 8/2/23.
//

import SwiftUI

@main
struct Libreria_TrantorApp: App {
    @StateObject var account = AccountObservableObject(networkClient: NetworkClient())
    @StateObject var base = BaseObservableObject()
    @StateObject var monitorNetwork = NetworkStatus()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(account)
                .environmentObject(base)
                .overlay {
                    if monitorNetwork.status == .offline {
                        AppOfflineView()
                            .transition(.opacity)
                    }
                }
                .animation(.default, value: monitorNetwork.status)
        }
        
    }
}
