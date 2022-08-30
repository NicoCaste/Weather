//
//  FloatExtension.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import Foundation

extension Float {
    
    func fromKelvinToCelcius() -> Float {
        return self - 273.15
    }
}
