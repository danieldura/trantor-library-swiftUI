//
//  OffsetObservingScrollView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI





struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.vertical]
    var showsInficators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content
    
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsInficators) {
            PositionObservingView(coordinateSpace: .named(coordinateSpaceName), position: Binding(get: {
                offset
            }, set: { newOffset in
                offset = CGPoint(
                    x: -newOffset.x, y: -newOffset.y)
            }), content: content)
        }.coordinateSpace(name: coordinateSpaceName)
    }
}


struct PositionObservingView<Content:View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(key: PreferenceKey.self, value: geometry.frame(in: coordinateSpace).origin)
            }).onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    enum PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // nothing
        }
    }
}
struct OffsetObservingScrollView_Previews: PreviewProvider {
    @State static var position = CGPoint.zero
    static var previews: some View {
        OffsetObservingScrollView(offset: $position, content: {
            Text("hola")
        })
    }
}
