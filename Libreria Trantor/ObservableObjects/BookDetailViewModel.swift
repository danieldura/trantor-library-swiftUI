//
//  BookDetailViewModel.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 17/2/23.
//

import Foundation

final class BookDetailViewModel: BaseObservableObject {   
    
    var book: BookModel
    
    init(book: BookModel) {
        self.book = book
    }
}
