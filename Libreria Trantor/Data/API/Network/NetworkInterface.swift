//
//  NetworkInterface.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 8/3/23.
//

import Foundation

let serverURL = URL(string: "https://trantorapi-acacademy.herokuapp.com/api")!



public enum HTTPMethods: String {
    case GET
    case POST
    case UPDATE
    case DELETE
}

extension URL {
    static let getUser = serverURL.appending(component: "client/query")
}
