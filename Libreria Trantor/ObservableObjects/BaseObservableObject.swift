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
    
    @Published var user:User = DataEncryptionManager.shared.get(key: .user, type: User.self) ?? User.test
    @Published var screen:Screens = .authentification
    
    
    init() {
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
            errorMsg = aPIErrorResponse.reason
            showAlert = true
            print(aPIErrorResponse.reason)
        default:
//            alertTitle = "error_popup_title"
//            alertMessage = "error_popup_message"
//            showError = true
            print("default error")
        }
    }
    func saveUserData() {
        do{
            try DataEncryptionManager.shared.save(user, key: .user)
        }catch {
            print("Error savind Data: \(error)")
        }
        
    }
    
    @MainActor
    func fetchOrders() async {
        do {
            let orders:Orders = try await NetworkClient().doRequest(request: ShopRequest.orders(user))
            user.orders = orders
            saveUserData()
        } catch let error as NetworkError {
            errorMsg = error.localizedDescription
            showNetworkError(error)
        } catch {
            print(error)
        }
    }
}
