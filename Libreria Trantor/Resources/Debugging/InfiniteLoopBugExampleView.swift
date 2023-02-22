//
//  InfiniteLoopBugExampleView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 22/2/23.
// https://www-hackingwithswift-com.translate.goog/quick-start/swiftui/how-to-find-which-data-change-is-causing-a-swiftui-view-to-update?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=en-US&_x_tr_pto=wapp

import SwiftUI

struct InfiniteLoopBugExampleView: View {
    @StateObject private var evilObject = EvilStateObject()
    var body: some View {
        let _ = Self._printChanges()
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(.random)
    }
}

struct InfiniteLoopBugExampleView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteLoopBugExampleView()
    }
}


class EvilStateObject: ObservableObject {
    var timer:Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if Int.random(in: 1...5) == 1 {
                self.objectWillChange.send()
            }
        })
    }
}
