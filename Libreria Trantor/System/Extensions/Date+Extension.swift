//
//  Date+Extension.swift
//  DDura Libreria Trantor
//
//  Created by Dani Durà on 30/3/23.
//

import Foundation

extension Date {
    var dayMonthYaerWithTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}
