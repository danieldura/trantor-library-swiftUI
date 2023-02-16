//
//  RatingView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 16/2/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: self.starType(for: index))
                    .foregroundColor(self.starColor(for: index))
            }
        }
    }
    
    func starType(for index: Int) -> String {
        return index >= Int(rating) ? "star" : "star.fill"
    }
    
    func starColor(for index: Int) -> Color {
        let decimalPart = rating - Double(Int(rating))
        if index < Int(rating) {
            return .yellow
        } else if index == Int(rating) && decimalPart > 0 {
            return Color.yellow.opacity(Double(decimalPart))
        } else {
            return .gray
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 3.5)
    }
}
