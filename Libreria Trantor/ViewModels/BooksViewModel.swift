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
    @Published var books: [BookModel]
    
    var filteredBooks: [BookModel] {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    init() {
        books = persistence.fetchBooks()
    }
    
    
}
