//
//  ShakeAnimation.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 30/3/23.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        let unit = size.width / CGFloat(shakesPerUnit)
        let x = sin(animatableData * .pi * CGFloat(shakesPerUnit)) * amount * (animatableData > 0 ? 1 : 0)
        return ProjectionTransform(CGAffineTransform(translationX: x * unit, y: 0))
    }
}
