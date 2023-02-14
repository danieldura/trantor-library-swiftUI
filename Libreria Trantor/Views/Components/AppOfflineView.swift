//
//  AppOfflineView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 14/2/23.
//

import SwiftUI

struct AppOfflineView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.red)
                .ignoresSafeArea()
            VStack {
                Text("NoInternetTitle".localized)
                    .font(.headline)
                Text("NoInternetDescription".localized)
            }
        }
    }
}

struct AppOfflineView_Previews: PreviewProvider {
    static var previews: some View {
        AppOfflineView()
    }
}
