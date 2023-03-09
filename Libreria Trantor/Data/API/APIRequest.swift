//
//  APIRequest.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 9/3/23.
//

import Foundation

protocol APIRequest {
    var serviceName: String { get }
    var url:String { get }
    var subPath:String? { get }
    var path:String { get }
    var method: HTTPMethods { get }
    var queryItems: [URLQueryItem]? { get }
    var params: Any? { get }
    var timeOut: TimeInterval { get }
    var isTimeOutIgnorable: Bool {get  }
}

extension APIRequest {
    var timeOut: TimeInterval { 10.0 }
}
