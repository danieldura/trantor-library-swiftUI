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
    
    enum LoginError:Error {
        case email
        case password
    }
    
    @Published var authenticationState: AuthenticationState = .loggedOut
    @Published var email:String = ""
    @Published var errorMsg = ""
    @Published var showAlert = false
    
    
    
    @MainActor
    func login(email:String, pass:String) async{
            authenticationState = .authenticating

            // Simulating network call for authentication
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if email == User.test.email {
                    self.authenticationState = .loggedIn
                } else {
                    self.authenticationState = .authenticationFailed
                }
            }
        }
}
