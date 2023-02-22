//
//  BooksViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import Foundation

final class BooksViewModel: ObservableObject {
    enum SortType:String, CaseIterable {
        case ascending = "Ascending"
        case descending = "Desdending"
        case none = "None"
    }
    
    var persistence = ModelPersistence()
    
    @Published var searchText:String = ""
    @Published private (set) var books: Books
    @Published var suggestedBooks: Books
    @Published var searchedBooks: Books
    @Published private (set) var cartBooks: Books
    
    
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
    
    func makeOrder(){
        
    }
    func isBookInCart(_ book: BookModel) -> Bool {
        cartBooks.contains(where: { $0 == book })
    }
}
