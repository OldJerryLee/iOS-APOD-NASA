//
//  String+Extensions.swift
//  APOD
//
//  Created by Fabricio Pujol on 15/02/25.
//

import Foundation

extension String {
    func toFormattedDate(inputFormat: String = "yyyy-MM-dd", outputFormat: String = "dd/MM/yyyy") -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "pt_BR")
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
}
