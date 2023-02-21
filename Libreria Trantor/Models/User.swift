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
    var role:UserRole? = .client
    let location:String?
    let name:String?
    let favoriteBooks: Books?
    let readBooks: Books?
    let orderedBooks: Books?
    let orders:orders?
    
    static var test:User {
        User(id: 1, email: "hola@ddura.es", role:.admin, location: "Altea",name: "Dani", favoriteBooks: [.test], readBooks: [.test],orderedBooks: [.test], orders: [.test])
    }
    
    enum UserRole:String, CaseIterable, Codable {
        case admin = "admin"
        case client = "client"
    }
}


