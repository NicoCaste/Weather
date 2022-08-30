//
//  Geocoding.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation
import UIKit

struct Geocoding: Codable, Hashable {
    var name: String?
    var lat: Float?
    var lon: Float?
    var country: String?
}
