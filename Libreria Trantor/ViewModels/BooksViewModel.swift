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
    @Published var books: Books
    @Published var latestBooks: Books
    
    var authors: Authors
    
    var filteredBooks: Books {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    init() {
        authors = persistence.fetchAuthors()
        books = persistence.fetchBooks()
        latestBooks = persistence.fetchBooks(url: .latestBooksDataURL)
    }
    
    func fetchAuthorName(from book: BookModel) -> String? {
        authors.first(where: {$0.id == book.author})?.name
    }

    
}
