//
//  UserViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 21/2/23.
//

import Foundation



final class AccountObservableObject:BaseObservableObject {
    enum AuthenticationState {
        case loggedIn
        case loggedOut
        case authenticating
        case authenticationFailed
    }
    
    enum LoginError:Error {
        case mandatoryEmail
        case invalidEmail
        case mandatoryPassword
        case userNotFound
        case userActivationNeeded
        
        var description:String {
            switch self {
            case .mandatoryEmail : return "error email"
            case .invalidEmail:
                return "error email"
            case .mandatoryPassword:
                return "error password"
            case .userNotFound:
                return "error user not found"
            case .userActivationNeeded:
                return "error user activation needed"
            }
        }
    }
    
    @Published var authenticationState: AuthenticationState = .loggedOut
    
    
    
    @MainActor
    func login(email:String, pass:String) async {
        authenticationState = .authenticating
        
        if email.isEmpty {
            errorMsg = LoginError.mandatoryEmail.description
            return
        }
        if pass.isEmpty {
            errorMsg = LoginError.mandatoryPassword.description
            return
        }
        if email.isEmail {
            errorMsg = LoginError.invalidEmail.description
            return
        }
        do {
            let user = User(id: 0, email: email, isLoged: false)
            let request = AuthenticationRequest.login(user)
            let userLoged = try await NetworkClient.shared.fetch(apiRequest: request)
        }
            
        if email == User.test.email {
            self.authenticationState = .loggedIn
            user.isLoged = true
            
        } else {
            self.authenticationState = .authenticationFailed
            user.isLoged = false
//            throw LoginError.password
        }
    }
    
}
