//
//  ClientModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

struct User: Codable, Hashable, Identifiable {
    let id: Int
    var email:String
    var role:UserRole? = .client
    var location:String?
    var name:String?
    var favoriteBooks: Books?
    var readBooks: Books?
    var orderedBooks: Books?
    var orders:orders?
    
    static var test:User {
        User(id: 1, email: "hola@ddura.es", role:.admin, location: "Altea",name: "Dani", favoriteBooks: [.test], readBooks: [.test],orderedBooks: [.test], orders: [.test])
    }
    
    enum UserRole:String, CaseIterable, Codable {
        case admin = "admin"
        case client = "client"
    }
}


