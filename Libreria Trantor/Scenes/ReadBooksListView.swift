//
//  FavoriteBooksListView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct ReadBooksListView: View {
    @EnvironmentObject var vm:BaseObservableObject
    
    var columns = [GridItem(.adaptive(minimum: 150),spacing: 20)]
    
    var body: some View {
        ScrollViewDDura(title:"Readed Books".localized, headerGradient: Gradient(colors: [.random, .random])) {
            if vm.readBooks.isEmpty {
                Text("Add Readed books by *swiping*\nto the left in the books list")
                    .multilineTextAlignment(.center)
                    .bold()
            } else {
                LazyVGrid(columns: columns,spacing: 20) {
                    ForEach(vm.readBooks, id: \.id) { book in
                        BookCardComponentView(book: book)
                    }
                }.padding()
                
            }
        }
    }
}

struct FavoriteBooksListView_Previews: PreviewProvider {
    static var previews: some View {
        ReadBooksListView().environmentObject(BaseObservableObject())
    }
}
