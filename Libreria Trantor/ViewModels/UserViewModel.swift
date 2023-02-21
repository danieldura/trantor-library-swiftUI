//
//  UserViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 21/2/23.
//

import Foundation

final class UserViewModel:ObservableObject {
    var persistence = ModelPersistence()
    
    var user:User
    
    init(user:User) {
        self.user = user
    }
}
