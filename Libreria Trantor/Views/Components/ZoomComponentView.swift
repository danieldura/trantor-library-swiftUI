//
//  ZoomImageComponentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 17/2/23.
//

import SwiftUI

struct ZoomComponentView<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    @State var touched = false
    @State var offset = CGSize.zero
    @State var position = CGPoint.zero
    @State var pinch:CGFloat = 1.0
    @GestureState var rotation:Angle = .zero
    var body: some View {
        content()
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: touched ? 350 : 250)
            .offset(offset)
            .scaleEffect(pinch)
            .rotationEffect(rotation)
            .overlay {
                Image(systemName:touched ? "heart.fill" : "")
                    .font(.system(size: 50))
                    .foregroundColor(touched ? .red : .gray)
                    .padding()
            }
            .onTapGesture(count: 2) {
                withAnimation(.easeOut(duration: 1)) {
                    touched.toggle()
                }
            }

            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation { offset = value.translation }
                    }
                    .onEnded { _ in
                        withAnimation { offset = .zero }
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        withAnimation { pinch = value }
                    }
                    .onEnded { _ in
                        withAnimation { pinch = 1.0 }
                    }
                    .simultaneously(with: RotationGesture()
                        .updating($rotation) { angle, state, _ in
                            withAnimation { state = angle }
                        }
                    )
            )
    }
}

struct ZoomImageComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomComponentView(content: {
            Image(systemName: "star.fill")
        })
    }
}
