//
//  BooksStoreObsevableObject.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 20/3/23.
//

import Foundation

final class BooksStoreObservableObject:BaseObservableObject {
    @Published var searchText:String = ""
    @Published private (set) var books: Books = []
    @Published var suggestedBooks: Books = []
    @Published var searchedBooks: Books = []
    @Published private (set) var cartBooks: Books = []
    @Published private (set) var readBooks: Books = []
    @Published private (set) var lovedBooks: Books = []
    
    var latestBooks: Books = []
    
    var authors: Authors = []
    var filteredBooks: Books {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
        
        
    override init() {
        super.init()
        authors = self.persistence.fetchAuthors()
        books = self.persistence.fetchBooks()
        latestBooks = self.persistence.fetchBooks(url: .latestBooksDataURL)
        suggestedBooks = latestBooks.shuffled().suffix(3)
        searchedBooks = latestBooks.shuffled().suffix(3)
        cartBooks = user.cartBooks ?? []
        readBooks = user.readBooks ?? []
        lovedBooks = []
    }
    
    func fetchAuthorName(from book: BookModel) -> String? {
        authors.first(where: {$0.id == book.author})?.name
    }

    func removeFromCart(book:BookModel){
        cartBooks = cartBooks.filter { $0.id != book.id }
    }
    
    func toggleBookOnCart(book:BookModel) {
        if cartBooks.contains(where: { $0 == book}) {
            cartBooks.removeAll(where: { $0 == book})
        } else {
            cartBooks.append(book)
        }
        user.cartBooks = cartBooks
        saveUserData()
    }
    @MainActor
    func makeOrder() async {
        if cartBooks.isEmpty { return }
        
        let newOrder = NewOrder(email: user.email, pedido: cartBooks.map { $0.id })
        do {
            let orderResponse:OrderModel = try await NetworkClient().doRequest(request: ShopRequest.newOrder(newOrder))
            user.orders?.append(orderResponse)
            cleanCart()
            saveUserData()
        } catch let error as NetworkError {
            errorMsg = error.localizedDescription
            showNetworkError(error)
        } catch {
            print(error)
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
    
    func cleanCart() {
        cartBooks.removeAll()
    }
    
    func isBookInCart(_ book: BookModel) -> Bool {
        cartBooks.contains(where: { $0 == book })
    }
    
    func toggleReadBook(book:BookModel){
        if readBooks.contains(where: { $0 == book}) {
            readBooks.removeAll(where: { $0 == book})
        } else {
            readBooks.append(book)
        }
    }
    func isReadedBook(_ book: BookModel) -> Bool {
        readBooks.contains(where: { $0 == book })
    }
}
