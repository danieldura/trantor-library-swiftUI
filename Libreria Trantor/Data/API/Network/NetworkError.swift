//
//  NetworkError.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

struct APIErrorResponse: Codable {
    let error: Bool
    let reason: String
}

enum NetworkError: Error {
    case connectionError
    case responseError
    case encodingError
    case authenticationError
    case timeoutError
    case URLError
    case status(Int)
    case general(Error)
    case apiError(APIErrorResponse)
    
    var description: String {
        switch self {
        case .connectionError:
            return "connection_error".localized
        case .responseError:
            return "response_error".localized
        case .encodingError:
            return "encoding_error".localized
        case .authenticationError:
            return "authentication_error".localized
        case .timeoutError:
            return "timeout_error".localized
        case .URLError:
            return "url_error".localized
        case .status(let int):
            if int == 404 {
                return "Not Found".localized
            } else {
                return "Server Status Error: %@".localized(with: int)
            }
        case let .general(error): return "Error de construcción \(error)"
        case .apiError(let apiError): return apiError.reason
        }
        
        
    }
}
