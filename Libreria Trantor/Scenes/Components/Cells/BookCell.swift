//
//  BookCell.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct BookCell: View {    
    
    let book:BookModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                if let authorName = book.authorString {
                    Text(authorName)
                }
                HStack{
                    Text("\(book.year)")
                    Spacer()
                    RatingView(rating: book.rating ?? 0)
                }
            }
            Spacer()
            AsyncImage(url: book.cover) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width:70)
                    .background {
                        Color.gray.opacity(0.2)
                    }
            } placeholder: {
                Image(systemName: "book.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
            }
        }
        .background(book.read ?? false ? Color.green.opacity(0.1) : Color.clear)
        .animation(.easeInOut,value: book.read)
        
    }
}

struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCell(book: .test)
    }
}
