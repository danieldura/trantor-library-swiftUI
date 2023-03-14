//
//  ApplePayButtonComponentView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 22/2/23.
//

import SwiftUI
import PassKit

struct ApplePayButtonComponentView: View {
    var action: () -> Void
    
    var body: some View {
        Representable(action: action)
            .frame(minWidth: 100)
            .frame(height: 45)
            .frame(maxWidth: .infinity)
        
    }
}

struct ApplePayButtonComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ApplePayButtonComponentView(action:{})
    }
}


extension ApplePayButtonComponentView {
    struct Representable: UIViewRepresentable {
        var action: () -> Void
        
        
        func makeCoordinator() -> Coordinator {
            Coordinator(action: action)
        }
        
        func makeUIView(context: Context) -> some UIView {
            context.coordinator.button
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            context.coordinator.action = action
        }
    }
    
    class Coordinator: NSObject {
        var action: () -> Void
        var button: PKPaymentButton
        let paymentButtonType: PKPaymentButtonType = .support
        let paymentButtonStyle: PKPaymentButtonStyle = .automatic
        
        init(action: @escaping () -> Void) {
            self.action = action
            self.button = PKPaymentButton(paymentButtonType: paymentButtonType, paymentButtonStyle: paymentButtonStyle)
            super.init()

            button.addTarget(self, action: #selector(callback(_:)), for: .touchUpInside)
        }
        
        @objc func callback(_ sender: Any) {
            action()
        }
    }
}
