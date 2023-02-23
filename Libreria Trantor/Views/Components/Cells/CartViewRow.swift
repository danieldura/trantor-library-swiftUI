//
//  CartViewRow.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 22/2/23.
//

import SwiftUI

struct CartViewRow: View {
    @EnvironmentObject var vm:BooksViewModel
    var book: BookModel
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: book.cover) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
//                    .cornerRadius(10)
                    .shadow(radius: 20)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading,spacing: 10) {
                Text(book.title)
                Text(vm.fetchAuthorName(from: book) ?? "Nombre del autor")
                    .font(.footnote)
            }
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    vm.removeFromCart(book: book)
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CartViewRow_Previews: PreviewProvider {
    static var previews: some View {
        CartViewRow(book: .test).environmentObject(BooksViewModel())
    }
}
