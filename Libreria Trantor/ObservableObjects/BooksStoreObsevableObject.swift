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
    @Published var cartBooks: Books = []
    @Published private (set) var readBooks: Books = []
    @Published private (set) var lovedBooks: Books = []
    
    var latestBooks: Books = []
    
    var authors: Authors = []
    var filteredBooks: Books {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    var orderedBooks: Books = []
    
    override init() {
        super.init()
        authors = self.persistence.fetchAuthors()
        books = getBookList(list:self.persistence.fetchBooks())
        latestBooks = self.persistence.fetchBooks(url: .latestBooksDataURL)
        cartBooks = user.cartBooks ?? []
        readBooks = user.readBooks ?? []
        lovedBooks = []
    }
    
    func fetchAuthorName(from book: BookModel) -> String? {
        authors.first(where: {$0.id == book.author})?.name
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
    private func getBookList(list:Books) -> Books {
        list.map { book in
            var book = book
            book.authorString = authors.first(where: { $0.id == book.author })?.name
            book.read = readBooks.contains(book)
            book.purchased = orderedBooks.contains(book)
            return book
        }
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
    func fetchReadAndOrderedBooks () async {
        do {
            let readAndOrderedBooks:ClientReportResponse = try await NetworkClient().doRequest(request: ClientRequest.report(user))
            let readBooksFromNetwork = getBooksFromIDs(booksIDs: readAndOrderedBooks.readed ?? [])
            let orderedBooksFromNetwork = getBooksFromIDs(booksIDs: readAndOrderedBooks.ordered ?? [])
            user.readBooks = readBooksFromNetwork
            readBooks = readBooksFromNetwork
            user.orderedBooks = orderedBooksFromNetwork
            orderedBooks = orderedBooksFromNetwork
            books = getBookList(list: books)
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
        user.cartBooks = []
    }
    
    func getBooksFromIDs(booksIDs: [Int]) -> Books {
        booksIDs.compactMap { idBook in
            getBookFromID(bookID: idBook)
        }
    }
    
    func getBookFromID(bookID: Int) -> BookModel? {
        books.first { $0.id == bookID }
    }
    
    func isBookInCart(_ book: BookModel) -> Bool {
        cartBooks.contains(where: { $0 == book })
    }
    
    
    
// MARK: Read books
    @MainActor
    func toggleReadBook(book:BookModel) {
        Task { [weak self] in
            guard let self = self else { return }
            let userReadBook = ReadBooksModel(email: user.email, books: [book.id])
            do {
                let _:EmptyResponse = try await NetworkClient().doRequest(request: ClientRequest.setReadBooks(userReadBook))
                if self.readBooks.contains(where: { $0 == book}) {
                    self.readBooks.removeAll(where: { $0 == book})
                } else {
                    self.readBooks.append(book)
                }
                self.books = updateBookReadStatus(list: books, bookToUpdate: book)
                self.user.readBooks = readBooks
                self.saveUserData()
            } catch let error as NetworkError {
                self.errorMsg = error.localizedDescription
                self.showNetworkError(error)
            } catch {
                print(error)
            }
        }
    }
    func isReadedBook(_ book: BookModel) -> Bool {
        readBooks.contains(where: { $0 == book })
    }
    
    private func updateBookReadStatus(list:Books, bookToUpdate: BookModel) -> Books {
        var books = list
        if let index = list.firstIndex(where: { $0.id == bookToUpdate.id }) {
            books[index].read = !(list[index].read ?? true)
        }
        return books
    }
}
