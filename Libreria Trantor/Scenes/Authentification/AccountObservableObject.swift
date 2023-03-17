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
    
    var networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    @MainActor
    func login(email:String, pass:String) async {
        authenticationState = .authenticating
        
        if email.isEmpty {
            errorMsg = LoginError.mandatoryEmail.description
            failedAuthentication()
            return
        }
        if pass.count < 8{
            errorMsg = LoginError.mandatoryPassword.description
            failedAuthentication()
            return
        }
        if !email.isEmail {
            errorMsg = LoginError.invalidEmail.description
            failedAuthentication()
            return
        }
        do {
            let request = AuthenticationRequest.login(User(id: 0, email: email))
            user = try await networkClient.doRequest(request:request)
//            try Storage.shared.save(user, key: .user)
            
            self.authenticationState = .loggedIn
            screen = .userHome
            user.isLoged = true
            
        } catch let error as NetworkError {
            self.showNetworkError(error)
            failedAuthentication()
        } catch {
            print(error)
            failedAuthentication()
        }
    }
    func failedAuthentication() {
        self.authenticationState = .authenticationFailed
        user.isLoged = false
    }
    
}
