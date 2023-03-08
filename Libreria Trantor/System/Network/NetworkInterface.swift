//
//  NetworkInterface.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 8/3/23.
//

import Foundation

let serverURL = URL(string: "https://trantorapi-acacademy.herokuapp.com/api")!



public enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

extension URL {
    static let getUser = serverURL.appending(component: "client/query")
}

extension URLRequest {
    static func request <T:Codable>(url:URL, method:HTTPMethods, body:T) -> URLRequest {
        var request = URLRequest(url:url)
        request.httpMethod = method.rawValue
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
