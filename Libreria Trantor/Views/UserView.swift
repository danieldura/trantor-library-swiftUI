//
//  UserView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 21/2/23.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var vm:UserViewModel
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            userInfo
            readedBooks
            orderedBooks
            ordersList            
        }

    }
}


extension UserView {
    var readedBooks: some View {
        Group {
            if let books = vm.user.readBooks {
                Text("Readed Books".localized)
                    .font(.title2)
                ForEach(books) { book in
                    Text(book.title)
                }
            } else {
                Text("No books read yet?".localized)
            }
        }
    }
    
    var userInfo: some View {
        Text("Welcome %@".localized(with: vm.user.name ?? "user"))
            .font(.largeTitle)
    }
    
    var orderedBooks: some View {
        Group {
            if let books = vm.user.orderedBooks {
                Text("Ordered Books".localized).font(.title2)
                ForEach(books) { book in
                    Text(book.title)
                }
            } else {
                Text("No ordered books?".localized)
            }
        }
    }
    
    var ordersList: some View {
        Group {
            if let orders = vm.user.orders {
                Text("Orders List".localized)
                    .font(.title2)
                ForEach(orders) { order in
                    Text("\(order.date)")
                }
            }else {
                Text("No orders".localized)
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(vm:UserViewModel(user: .test))
    }
}
