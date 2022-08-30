//
//  UIViewExtension.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import UIKit

extension UIView {
    func gradientBackground(topColor: CGColor, bottomColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func getColorWeatherConditionFor(id: Int) -> WeatherColor {
        // default Clear
        var topColor: CGColor = makeCGColor(240, 240, 255)
        var bottomColor: CGColor = makeCGColor(65, 171, 240)
        var headerColor: UIColor = .black
        switch id {
        //Thunderstorm
        case 200...232:
            topColor = makeCGColor(200, 200, 200)
            bottomColor = makeCGColor(1, 1, 1)
            headerColor = .darkGray
        //Drizzle
        case 300...321:
            topColor = makeCGColor(77, 167, 227)
            bottomColor = makeCGColor(60, 60, 60)
            headerColor = .darkGray
        //Rain
        case 500...531:
            topColor = makeCGColor(90, 100, 160)
            bottomColor = makeCGColor(100, 100, 100)
            headerColor = .darkGray
        //Snow
        case 600...622:
            topColor = makeCGColor(255, 255, 255)
            bottomColor = makeCGColor(186, 235, 255)
            headerColor = UIColor.init(red: 0, green: 115/255, blue: 227/255, alpha: 1)
        //Mist
        case 701...781:
            topColor =  makeCGColor(194, 222, 254)
            bottomColor = makeCGColor(104, 120, 160)
            headerColor =  UIColor.init(red: 0, green: 115/255, blue: 118/255, alpha: 1)
        //Clouds
        case 801...804:
            topColor = makeCGColor(240, 240, 255)
            bottomColor = makeCGColor(20, 20, 20)
        default:
            break
        }
        
        return WeatherColor(topColor: topColor, bottomColor: bottomColor, headerColor: headerColor)
    }
    
    func makeCGColor(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat? = nil) -> CGColor {
        CGColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha ?? 1)
    }
}
