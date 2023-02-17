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
//                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Books".localized)
            .searchable(text: $vm.searchText, tokens: $vm.latestBooks, suggestedTokens: $vm.latestBooks, placement: .automatic, prompt: "Search Book".localized) { token in
                Text(token.title)
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
