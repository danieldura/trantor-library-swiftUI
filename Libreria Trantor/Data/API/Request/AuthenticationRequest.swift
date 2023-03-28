//
//  AuthenticationRequest.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 10/3/23.
//

import Foundation

enum AuthenticationRequest {
    case login(User)
}

extension AuthenticationRequest: APIRequestable {
    var serviceName: String {
        switch self {
        case .login: return "user_login"
        }
    }
    
    var subPath: String {
        "/client"
    }
    
    var path: String {
        switch self {
        case .login: return "/query"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .login: return .POST
        }
    }
    
    var params: Any? {
        switch self {
        case .login(let user): return ["email": user.email] as [String:String]
        }
    }
    
    var isTimeOutIgnorable: Bool {
        return false
    }
    
    
}
