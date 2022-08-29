//
//  ApiKeyManager.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

final class ApiKeyManager {
    static func getOpenWeatherApiKey() -> String? {
         return  Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    }
}
