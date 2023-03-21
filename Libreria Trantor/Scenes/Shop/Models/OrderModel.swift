//
//  OrderModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation
typealias orders = [OrderModel]

struct OrderModel: Codable, Hashable, Identifiable {

    let id:UUID
    let state:OrderStatus
    let email:String
    let books:[Int]
    let date:Date
    
    
    enum CodingKeys: String, CodingKey {
        case id = "npedido"
        case state = "estado"
        case email, books, date
    }
    
    static var test:OrderModel {
        OrderModel(id: UUID(), state: .received, email: "hola@ddura.es", books: [1,2,3], date: Date())
    }
}

enum OrderStatus: String, Codable, CaseIterable, Identifiable {
    var id: Self { return self }
    case received = "recibido"
    case processing = "procesando"
    case sent = "enviado"
    case delivered = "entregado"
    case returned = "devuelto"
    case canceled = "anulado"
}
