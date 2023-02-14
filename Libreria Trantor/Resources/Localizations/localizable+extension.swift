//
//  localizable+extension.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 14/2/23.
//

import Foundation

extension String {
    var localized:String {
        NSLocalizedString(self, comment: "")
    }
}

