//
//  ApiUrlHelper.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

enum ApiCall: String {
    case weather = "data/2.5/forecast?"
    case geocoding = "geo/1.0/direct"
}

class ApiUrlHelper {
    static private var baseUrl = "https://api.openweathermap.org/"
    static func getApiUrl(call: ApiCall) -> String {
        return baseUrl + call.rawValue
    }
}
