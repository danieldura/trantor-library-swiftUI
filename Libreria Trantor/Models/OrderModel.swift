//
//  OrderModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

struct OrdelModel: Codable {
    let id:UUID
    let state:String
    let email:String
    let books:[BookModel]
    let date:Date
    
    
    enum CodingKeys: String, CodingKey {
        case id = "npedido"
        case state = "estado"
        case email, books, date
    }
    
    static var test:OrdelModel {
        OrdelModel(id: UUID(), state: "recibido", email: "hola@ddura.es", books: [BookModel.test], date: Date())
    }
}
