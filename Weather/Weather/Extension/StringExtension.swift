//
//  StringExtension.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation

import Foundation

extension String {
    enum FormatDateType: String {
        case year = "yyyy"
        case month = "MM"
        case day = "dd"
        case hourAndMinutes = "HH:mm"
        case hour = "HH"
        case yearMonth = "yyyy-MM"
        case yearMothDay = "yyyy-MM-dd"
    }
    
    func getDateFormatString(format: FormatDateType ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = format.rawValue
        let stringDateFormat = dateFormatter.string(from: date)
        return stringDateFormat
    }
    
    func localized () -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
