//
//  NSNotificationExtension.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation

extension NSNotification.Name {
    static var newCity: NSNotification.Name {
        return .init(rawValue: "newCity")
    }
    
    static var clearPrediction: NSNotification.Name {
        return .init(rawValue: "clearPrediction")
    }
    
    static var showErrorView: NSNotification.Name {
        return .init(rawValue: "showErrorView")
    }
}
