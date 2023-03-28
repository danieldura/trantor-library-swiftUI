//
//  ClientRequest.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 28/3/23.
//

import Foundation

enum ClientRequest {
    case report(User)
}

extension ClientRequest:APIRequestable {
    var subPath: String {
        "/client"
    }
    
    var path: String {
        switch self {
        case .report: return "/reportBooksUser"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .report: return .POST
        }
    }
    
    var params: Any? {
        switch self {
        case .report(let user): return ["email": user.email] as [String: String]
        }
    }
    
    var isTimeOutIgnorable: Bool {
        return false
    }
    
    
}
