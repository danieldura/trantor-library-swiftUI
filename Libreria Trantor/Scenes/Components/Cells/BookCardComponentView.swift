//
//  BookCardComponentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 23/2/23.
//

import SwiftUI

struct BookCardComponentView: View {
    @EnvironmentObject var vm:BaseObservableObject
    
    var book:BookModel
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                AsyncImage(url: book.cover) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(20)
                        .frame(width:180)
                        .scaledToFit()
                }placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(book.title).bold()
                    Text(vm.fetchAuthorName(from: book) ?? "")
                }
                .padding()
                .frame(width: 180,alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 180,height: 250)
            .shadow(radius: 3)
            
            Button {
                vm.toggleReadBook(book: book)
            } label: {
                Image(systemName: "minus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(50)
            }
            .padding()
        }
    }
}

struct BookCardComponentView_Previews: PreviewProvider {
    static var previews: some View {
        BookCardComponentView(book:.test).environmentObject(BaseObservableObject())
    }
}
