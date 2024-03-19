//
//  String+Extension.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 18.03.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self)_comment")
    }

    func localized(_ args: [CVarArg]) -> String {
        String(format: localized, args)
    }

    func localized(_ args: CVarArg...) -> String {
        String(format: localized, args)
    }
}
