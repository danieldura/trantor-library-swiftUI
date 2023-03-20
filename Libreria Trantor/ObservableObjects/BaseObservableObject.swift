//
//  BooksViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import Foundation

class BaseObservableObject: ObservableObject {
    
    var persistence = ModelPersistence()
    
    @Published var errorMsg = ""
    @Published var showAlert = false
    
    @Published var user:User
    @Published var screen:Screens = .authentification
    
    
    init() {
        user = DataEncryptionManager.shared.get(key: .user, type: User.self) ?? User.test
        screen = user.isLoged ?? false ? .userHome : .authentification
    }
    
    func loggedOut() {
        
        DataEncryptionManager.shared.cleanAll()
        screen = .authentification
        
    }
    
    @MainActor
    public func showNetworkError(_ error: NetworkError) {
//        showLoading(false)
        switch error {
        case .apiError(let aPIErrorResponse):
//            alertTitle = "error_title"
//            alertMessage = aPIErrorResponse.reason
//            showError = true
            print(aPIErrorResponse.reason)
        default:
//            alertTitle = "error_popup_title"
//            alertMessage = "error_popup_message"
//            showError = true
            print("default error")
        }
    }
}
