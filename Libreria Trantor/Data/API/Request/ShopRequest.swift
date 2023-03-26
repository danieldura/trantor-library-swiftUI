//
//  ShopRequest.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 21/3/23.
//

import Foundation

enum ShopRequest {
    case newOrder(NewOrder)
    case orders(User)
}

extension ShopRequest: APIRequestDelegate {
    var serviceName: String {
        switch self {
        case .orders: return "orders"
        case .newOrder: return "new-order"
        }
    }
    
    var subPath: String {
        "/shop"
    }
    
    var path: String {
        switch self {
        case .orders: return "/orders"
        case .newOrder: return "/newOrder"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .orders, .newOrder: return .POST
        }
    }
    
    var params: Any? {
        switch self {
        case .orders(let user): return ["email":user.email] as [String: String]
        case.newOrder(let order): return try? order.toDictionary()
        }
    }
    
    var isTimeOutIgnorable: Bool {
        return true
    }
    
    
}
