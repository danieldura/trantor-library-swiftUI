//
//  ClientModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: Int
    let email:String
    let role:String
    let location:String?
    let name:String?
    let favoriteBooks: Books?
    let readBooks: Books?
    
    static var test:User {
        User(id: 1, email: "hola@ddura.es", role: "admin", location: "Altea",name: "Dani", favoriteBooks: [.test], readBooks: [.test])
    }
    
    enum userRoleEnum {
        case admin
        case client
    }
}


