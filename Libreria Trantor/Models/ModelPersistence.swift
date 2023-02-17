//
//  ModelPersistence.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import Foundation

extension URL {
    static let booksDataURL = Bundle.main.url(forResource: "BooksData", withExtension: "json")!
    static let latestBooksDataURL = Bundle.main.url(forResource: "LatestBooksData", withExtension: "json")!
    static let authorDataUrl = Bundle.main.url(forResource: "AuthorsData", withExtension: "json")!
    
}

final class ModelPersistence {
    func fetchBooks(url: URL = .booksDataURL) -> Books {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Books.self, from: data)
        } catch {
            print("Error on load \(error)")
            return []
        }
    }
    
    func fetchAuthors(url: URL = .authorDataUrl) -> Authors {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Authors.self, from: data)
        } catch {
            print("Error on load \(error)")
            return []
        }
    }
    
}
