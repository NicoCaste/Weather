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
    case image
}

class ApiUrlHelper {
    static private var baseUrl = "https://api.openweathermap.org/"
    static private var baseUrlForImage = "https://openweathermap.org/"
    static func getApiUrl(call: ApiCall, imageId: String? = nil) -> String {
        var resource = call.rawValue
        var url = baseUrl
        switch call {
        case .image:
            resource = setImageName(id: imageId)
            url = baseUrlForImage
        default:
            break
        }
        
        return url + resource
    }
    
    static func setImageName(id: String?) -> String {
        guard let id = id else { return ""}
        return "img/wn/\(id)@2x.png"
    }
}
