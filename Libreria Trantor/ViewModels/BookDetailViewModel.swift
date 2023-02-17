//
//  BookDetailViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 17/2/23.
//

import Foundation

final class BookDetailViewModel: ObservableObject {
    var persistence = ModelPersistence()
    
    
    
    var book: BookModel
    
    init(book: BookModel) {
        self.book = book
    }
}
