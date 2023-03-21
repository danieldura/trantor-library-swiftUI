//
//  BookDetailView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct BookDetailView: View {
    @EnvironmentObject var booksVM:BooksStoreObservableObject
    @ObservedObject var vm:BookDetailViewModel
    var body: some View {
        ScrollView {
            
            principalImage(with: vm)
            authorView(with: booksVM, and: vm)
            Spacer(minLength: 32)
            spects(with: vm)
            Spacer(minLength: 32)
            
            longText(with: vm)
            

        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .navigationTitle("\(vm.book.title)")
    }
}

private extension BookDetailView {

    func spects(with book: BookDetailViewModel) -> some View {
        ExpandableComponentView {
            Text("Ficha Técnica".localized)
                .font(.headline)
        } content: {
            VStack(alignment: .leading, spacing: 10){
                if let pages = vm.book.pages {
                    HStack{
                        Text("Pages:".localized).bold()
                        Text("\(pages)")
                    }
                }
                if let isbn = vm.book.isbn {
                    HStack{
                        Text("ISBN:".localized).bold()
                        Text("\(isbn)")
                    }
                }
                HStack{
                    Text("Year:".localized).bold()
                    Text("\(vm.book.year)")
                }
                HStack{
                    Text("Rating:".localized).bold()
                    Text("\(vm.book.drawRating())")
                }
            }
        }

    }
    func principalImage(with vm:BookDetailViewModel) -> some View {
        ZoomComponentView {
            AsyncImage(url:vm.book.cover)
        }
    }
    func longText(with vm:BookDetailViewModel) -> some View {
        VStack(alignment: .leading) {
            if let summary = vm.book.summary {
                Text("Summary".localized)
                    .font(.headline)
                LongTextComponentView(longText:summary)
            }
            if let plot = vm.book.plot {
                Spacer(minLength: 32)
                Text("Plot".localized)
                    .font(.headline)
                
                LongTextComponentView(longText: plot)
            }
        }
    }
    func authorView(with vm:BooksStoreObservableObject, and bvm:BookDetailViewModel) -> some View {
        VStack{
            Text("Writed by...".localized)
                .font(.largeTitle)
            Text(vm.fetchAuthorName(from: bvm.book) ?? "")
        }
    }
    
}


struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(vm:BookDetailViewModel(book: .test))
            .environmentObject(BaseObservableObject())
    }
}
