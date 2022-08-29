//
//  ApiUrlHelper.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

class ApiUrlHelper {
    static private var baseUrl = "https://api.openweathermap.org/"
    
    enum ApiCall: String {
        case weather = "data/2.5/forecast?"
        case geocodin = "geo/1.0/direct"
    }

    static func getApiUrl(call: ApiCall) -> String {
        return baseUrl + call.rawValue
    }
}
