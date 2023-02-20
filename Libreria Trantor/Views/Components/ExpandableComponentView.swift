//
//  ExpandableComponentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 20/2/23.
//

import SwiftUI

struct ExpandableComponentView<Header: View, Content: View>: View {
    @State var isExpanded: Bool = false
    
    
    var header: () -> Header
    var content: () -> Content
    
    var body: some View {
        Section {
            if isExpanded {
                content()
            }
            
        } header: {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    header()
                    Spacer()
                    
                    Image(systemName: "chevron.up")
                        .rotationEffect(.degrees(isExpanded ? 180 : 360))
                        .animation(Animation.easeOut(duration: 0.3), value: isExpanded)
                }
            }
        }
        
    }
}

struct ExpandableComponentView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section {
                ExpandableComponentView(header: {
                    Text("Label Test...")
                }, content: {
                    VStack {
                        ForEach(0..<6) { index in
                            Text("Content Text \(index + 1)")
                        }
                        
                    }
                })
            }
        }
    }
}
