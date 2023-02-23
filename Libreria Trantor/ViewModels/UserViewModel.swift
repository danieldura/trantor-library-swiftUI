//
//  UserViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 21/2/23.
//

import Foundation



final class UserViewModel:ObservableObject {
    enum AuthenticationState {
        case loggedIn
        case loggedOut
        case authenticating
        case authenticationFailed
    }
    
    @Published var user:User
    @Published var authenticationState: AuthenticationState = .loggedOut
    var password:String = ""
    var errorMsg = ""
    
    init(user:User) {
        self.user = user
    }
    
    func login() {
            authenticationState = .authenticating

            // Simulating network call for authentication
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if self.user.email == User.test.email {
                    self.authenticationState = .loggedIn
                } else {
                    self.authenticationState = .authenticationFailed
                }
            }
        }
}
