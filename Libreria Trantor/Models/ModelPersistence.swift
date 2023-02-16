//
//  ModelPersistence.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import Foundation

extension URL {
    static let booksDataURL = Bundle.main.url(forResource: "BooksData", withExtension: "json")!
    static let authorDataUrl = Bundle.main.url(forResource: "AuthorsData", withExtension: "json")!
}

final class ModelPersistence {
    func fetchBooks(url: URL = .booksDataURL) -> [BookModel] {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([BookModel].self, from: data)
        } catch {
            
            print("Error on load \(error)")
            return []
        }
    }
}
