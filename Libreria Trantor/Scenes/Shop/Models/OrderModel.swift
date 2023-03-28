//
//  OrderModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation
typealias Orders = [OrderModel]

struct OrderModel: Codable, Hashable, Identifiable {
    let id:UUID = UUID()
    let idAPI:String
    let state:OrderStatus
    let email:String
    let books:[Int]
    let date:Date
    
    
    enum CodingKeys: String, CodingKey {
        case idAPI = "npedido"
        case state = "estado"
        case email, books, date, id
    }
    
    static var test:OrderModel {
        OrderModel(idAPI: "E627160D-3862-4513-9D8F-38B4E74D06E8", state: .received, email: "hola@ddura.es", books: [1,2,3], date: Date())
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

struct NewOrder:Codable {
    let email:String
    let pedido:[Int]
}
