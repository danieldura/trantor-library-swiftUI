//
//  UserView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 21/2/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var vm:UserViewModel
    var body: some View {
        Text("Welcome %@".localized(with: vm.user.name ?? "user"))
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(vm:UserViewModel(user: .test))
    }
}
