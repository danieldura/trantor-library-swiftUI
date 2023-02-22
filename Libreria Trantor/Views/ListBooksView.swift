//
//  ListBooksView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct ListBooksView: View {
    @EnvironmentObject var vm:BooksViewModel
    
    var body: some View {
        NavigationStack {
            List(vm.filteredBooks) { book in
                NavigationLink(value:book) {
                    BookCell(book: book,authorName: vm.fetchAuthorName(from: book))
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        vm.addToCart(book: book)
                    } label: {
                        vm.isBookInCart(book) ?
                        Image(systemName: "plus") : Image(systemName: "plus")
                    }
                    .tint(vm.isBookInCart(book) ? .gray : .green)
                }
            }
            .navigationTitle("Books".localized)
            .searchable(text: $vm.searchText, tokens: $vm.searchedBooks, suggestedTokens: $vm.suggestedBooks, placement: .automatic, prompt: "Search Book".localized) { token in
                NavigationLink {
                    BookDetailView(vm: BookDetailViewModel(book: token))
                } label: {
                    Text(token.title)
                }                
            }
            .toolbar {
                NavigationLink {
                    CartView()
                } label: {
                    CartButton(numberOfBooks: vm.cartBooks.count)
                }
            }
            .navigationDestination(for: BookModel.self) { book in
                BookDetailView(vm: BookDetailViewModel(book: book))
            }
        }
    }
}
    

struct ListBooksView_Previews: PreviewProvider {
    static let vm = BooksViewModel()
    static var previews: some View {
        ListBooksView()
            .environmentObject(vm)
    }
}
