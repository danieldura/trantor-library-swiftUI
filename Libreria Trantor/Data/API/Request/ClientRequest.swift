//
//  ClientRequest.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 28/3/23.
//

import Foundation

enum ClientRequest {
    case report(User)
    case setReadBooks(ReadBooksModel)
}

extension ClientRequest:APIRequestable {
    var subPath: String {
        "/client"
    }
    
    var path: String {
        switch self {
        case .report: return "/reportBooksUser"
        case .setReadBooks: return "/readQuery"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .report, .setReadBooks : return .POST
            
        }
    }
    
    var params: Any? {
        switch self {
        case .report(let user): return ["email": user.email] as [String: String]
        case .setReadBooks(let readBooksModel): return try? readBooksModel.toDictionary()
        }
    }
    
    var isTimeOutIgnorable: Bool {
        return false
    }
    
    
}
