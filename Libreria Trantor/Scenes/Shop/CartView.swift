//
//  CartView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 21/2/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var vm: BooksStoreObservableObject
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView{
            if vm.cartBooks.count > 0 {
                ForEach(vm.cartBooks, id: \.id) { book in
                    CartViewRow(book: book)
                        .transition(.opacity)
                }
                .onDelete(perform: delete)
                HStack {
                    Text("Your order total is".localized)
                    Spacer()
                    Text("\(vm.cartBooks.count)")
                        .bold()
                }
                .padding()
                
                ApplePayButtonComponentView(action: makeOrder )
                    .padding()
            }else {
                VStack(spacing:10) {
                    Text("Your order is empty.".localized)
                        .font(.title)
                    Text("Add favorite episodes by *swiping*\nto the right in the books list")
                        .multilineTextAlignment(.center)
                        .bold()
                }                
            }
            
        }.navigationTitle(Text("My Order"))
            .padding(.top)
//            .onDisappear {
//                makeOrder()
//            }
        
    }
    func makeOrder() {
        presentationMode.wrappedValue.dismiss()
        Task {
            await vm.makeOrder()
        }
    }
    
    func delete(at offsets: IndexSet) {
        vm.cartBooks.remove(atOffsets: offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(BooksStoreObservableObject())
    }
}
