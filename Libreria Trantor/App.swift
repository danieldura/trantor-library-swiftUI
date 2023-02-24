//
//  App.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 24/2/23.
//

import Foundation

final class App {
    enum State {
        case unregistered
        case loggedIn(User)
        case sessionExpired(User)
    }
    
    var state: State = .unregistered
    
    
    func register(user:User) {
        state = .loggedIn(user)
    }
    
    func login(user:User){
        state = .loggedIn(user)
    }

    func logout() {
        if case let .loggedIn(user) = state {
            state = .sessionExpired(user)
        }
    }

    func renewSession() {
        if case let .sessionExpired(user) = state {
            state = .loggedIn(user)
        }
    }
}

