//
//  FavoriteBooksListView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct ReadBooksListView: View {
    @EnvironmentObject var vm:BooksViewModel
    
    var columns = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    
    var body: some View {
        if vm.readBooks.isEmpty {
            Text("Add Readed books by *swiping*\nto the left in the books list")
                .multilineTextAlignment(.center)
                .bold()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing:20) {
                    ForEach(vm.readBooks, id: \.id) { book in
                        BookCardComponentView(book: book)
                        
                    }
                }.padding()
            }.navigationTitle(Text("Readed books".localized))
                .navigationBarTitleDisplayMode(.automatic)
        }
       
    }
}

struct FavoriteBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadBooksListView()
    }
}
