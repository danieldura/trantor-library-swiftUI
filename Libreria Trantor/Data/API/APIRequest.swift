//
//  APIRequest.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 9/3/23.
//

import Foundation

protocol APIRequestDelegate {
    var serviceName: String { get }
    var url:String? { get }
    var subPath:String { get }
    var path:String { get }
    var method: HTTPMethods { get }
    var queryItems: [URLQueryItem]? { get }
    var params: Any? { get }
    var timeOut: TimeInterval { get }
    var isTimeOutIgnorable: Bool { get }
}

extension APIRequestDelegate {
    var timeOut: TimeInterval { 10.0 }
    var url: String? { nil }
    var queryItems:[URLQueryItem]? { nil }
}

struct APIRequest {
    var request:URLRequest
    init(apiRequest: APIRequestDelegate) {
        var urlComponents = URLComponents(string: apiRequest.url?.description ?? K.baseURL)
        let subpath = urlComponents?.path.appending(apiRequest.subPath) ?? ""
        let path = subpath.appending(apiRequest.path)
        
        urlComponents?.path = path
        
        if let queryItems = apiRequest.queryItems {
            urlComponents?.queryItems = queryItems
        }
        
        if let fullURL = urlComponents?.url {
          request = URLRequest(url: fullURL)
            request.httpMethod = apiRequest.method.rawValue
            if !apiRequest.isTimeOutIgnorable {
                request.timeoutInterval = apiRequest.timeOut
            }
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            if let params = apiRequest.params {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: params,options: .prettyPrinted)
                    request.httpBody = jsonData
                } catch {
                    print("Error serializing JSON data: \(error)")
                }
            }           
        } else {
            assertionFailure("URL error")
            request = URLRequest(url: URL(string: "")!)
        }        
    }
}
