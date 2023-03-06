//
//  BooksViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import Foundation

final class BooksViewModel: ObservableObject {
    
    var persistence = ModelPersistence()
    
    @Published var searchText:String = ""
    @Published private (set) var books: Books
    @Published var suggestedBooks: Books
    @Published var searchedBooks: Books
    @Published private (set) var cartBooks: Books
    @Published private (set) var readBooks: Books
    @Published private (set) var lovedBooks: Books
    @Published var user:User
    @Published var screen:Screens = .authentification
    
    
    var latestBooks: Books
    
    var authors: Authors
    
    var filteredBooks: Books {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    init() {
        authors = persistence.fetchAuthors()
        books = persistence.fetchBooks()
        latestBooks = persistence.fetchBooks(url: .latestBooksDataURL)
        suggestedBooks = latestBooks.shuffled().suffix(3)
        searchedBooks = latestBooks.shuffled().suffix(3)
        cartBooks = []
        readBooks = []
        lovedBooks = []
        user = User.test
    }
    
    func fetchAuthorName(from book: BookModel) -> String? {
        authors.first(where: {$0.id == book.author})?.name
    }

    func addToCart(book:BookModel){
        cartBooks.append(book)
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
    }
    
    func makeOrder(){
        
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
