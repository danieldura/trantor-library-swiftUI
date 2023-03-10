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
    func login(email:String, pass:String) async throws -> User? {
        authenticationState = .authenticating
        
        try await Task.sleep(nanoseconds:2_000_000_000)
        if email == User.test.email {
            
            self.authenticationState = .loggedIn
            return User.test
            
        } else {
            self.authenticationState = .authenticationFailed
            throw LoginError.password
        }
    }
    
}
