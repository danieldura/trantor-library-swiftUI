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
//                    .clipShape(Circle())
                
            } placeholder: {
                Image(systemName: "book.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
            }
        }
        .background(book.read ?? false ? Color.red : Color.clear)
    }
}

struct BookCell_Previews: PreviewProvider {
    static var previews: some View {
        BookCell(book: .test)
    }
}
