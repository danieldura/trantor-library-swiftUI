//
//  AuthorModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 15/2/23.
//

import Foundation

typealias Authors = [AuthorModel]

struct AuthorModel: Codable, Identifiable, Hashable {
    let id:UUID
    let name:String?
    
    static var test: AuthorModel {
        AuthorModel(id: UUID(), name: "H. G. Wells")
    }
}
