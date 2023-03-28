//
//  DateFormatter+Extension.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 17/3/23.
//

import Foundation


extension DateFormatter {
    static let jsonFormatter: DateFormatter = {
        let jsonFormatter = DateFormatter()
        jsonFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return jsonFormatter
    }()
    
}
