//
//  BookDetailView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct BookDetailView: View {
    
    @ObservedObject var vm:BookDetailViewModel
    var body: some View {
        
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(vm:BookDetailViewModel(book: .test))
    }
}
