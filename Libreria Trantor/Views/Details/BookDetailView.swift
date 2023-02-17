//
//  BookDetailView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var booksVM:BooksViewModel
    @ObservedObject var vm:BookDetailViewModel
    var body: some View {
        ScrollView {
            ZoomComponentView {
                AsyncImage(url:vm.book.cover)
            }

            Spacer(minLength: 32)
            
            
            VStack(alignment: .leading) {
                Text("Summary".localized)
                    .font(.headline)
                LongTextComponentView(longText:vm.book.summary ?? "")
               
                Spacer(minLength: 32)
                Text("Plot".localized)
                    .font(.headline)
                
                LongTextComponentView(longText: vm.book.plot ?? "")
            }
        }
        .padding()
        .navigationTitle("\(vm.book.title)")
    }
}


struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(vm:BookDetailViewModel(book: .test))
            .environmentObject(BooksViewModel())
    }
}
