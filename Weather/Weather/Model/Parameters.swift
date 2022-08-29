//
//  Parameters.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

struct Parameters: Codable {
    var appid: String?
    var q: String?
    var limit: Int?
    var lat: Float?
    var lon: Float?
    var id: Int?
}
