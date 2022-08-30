//
//  StringExtension.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation
import UIKit

extension String {
    enum FormatDateType: String {
        case year = "yyyy"
        case month = "MM"
        case day = "dd"
        case hourAndMinutes = "HH:mm"
        case hour = "HH"
        case yearMonth = "yyyy-MM"
        case yearMothDay = "yyyy-MM-dd"
        case dayName = "cccc"
    }
    
    func getDateFormatString(format: FormatDateType ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = format.rawValue
        let stringDateFormat = dateFormatter.string(from: date)
        return stringDateFormat
    }
    
    func localized () -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func setStringWithImageAttachment(imageName: String, imageSize: Int) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image  = UIImage(systemName: imageName)
        imageAttachment.image?.withTintColor(.black)
        imageAttachment.bounds.size = CGSize(width: imageSize, height: imageSize)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: self)
        completeText.append(textAfterIcon)
        return completeText
    }
    
}
