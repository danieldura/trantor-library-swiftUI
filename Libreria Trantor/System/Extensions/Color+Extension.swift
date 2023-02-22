//
//  Color+Extension.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 22/2/23.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in:0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
            )
    }
}
