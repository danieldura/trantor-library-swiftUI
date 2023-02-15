//
//  ClientModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

struct ClientModel: Codable, Hashable, Identifiable {
    let id: Int
    let email:String
    let role:String
    let location:String
    
    static var test:ClientModel {
        ClientModel(id: 1, email: "hola@ddura.es", role: "admin", location: "Altea")
    }
}


