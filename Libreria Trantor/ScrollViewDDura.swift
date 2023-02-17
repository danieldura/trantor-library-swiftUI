//
//  ContentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 8/2/23.
//

import SwiftUI

struct ScrollViewDDura<Content:View>: View {
    var title: String
    var headerGradient: Gradient
    @ViewBuilder var content: () -> Content
    
    private let headerHeight = (collapsed: 50.0, expanded:150.0)
    @State private var scrollOffset = CGPoint()
    
    var body: some View {
        GeometryReader { geometry in
            OffsetObservingScrollView(offset: $scrollOffset) {
                VStack {
                    makeHeaderText(collapsed: false)
                    content()
                }
                .padding()
            }.overlay(alignment:.top) {
                makeHeaderText(collapsed: true)
                    .background(alignment: .top) {
                        headerLinearGradient.ignoresSafeArea()
                    }.opacity(collapsedHeaderOpacity)
            }.background(alignment: .top) {
                headerLinearGradient.frame(height: max(0,headerHeight.expanded - scrollOffset.y) + geometry.safeAreaInsets.top).ignoresSafeArea()
            }
        }
    }
}


private extension ScrollViewDDura {
    var collapsedHeaderOpacity: CGFloat {
        let minOpacityOffset = headerHeight.expanded / 2
        let maxOpacityOffset = headerHeight.expanded - headerHeight.collapsed
        
        guard scrollOffset.y > minOpacityOffset else { return 0 }
        guard scrollOffset.y < maxOpacityOffset else { return 1 }
        
        let opacityOffsetRange = maxOpacityOffset - minOpacityOffset
        return (scrollOffset.y - minOpacityOffset) / opacityOffsetRange
    }
    
    var headerLinearGradient: LinearGradient {
        LinearGradient(gradient: headerGradient, startPoint: .top, endPoint: .bottom)
    }
    
    func makeHeaderText(collapsed: Bool) -> some View {
        Text(title)
            .font(collapsed ? .body : .title)
            .lineLimit(1)
            .padding()
            .frame(height: collapsed ? headerHeight.collapsed : headerHeight.expanded)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .accessibilityHeading(.h1)
            .accessibilityHidden(collapsed)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewDDura(title: "Trantor Library".localized, headerGradient: Gradient(colors: [.red,.secondary]), content: {
                
        })
    }
}

