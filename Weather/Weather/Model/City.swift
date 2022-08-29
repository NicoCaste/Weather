//
//  City.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var sunrise: Int?
    var sunset: Int? 
}

struct Coord: Codable {
    var lat: Float?
    var lon: Float?
}
