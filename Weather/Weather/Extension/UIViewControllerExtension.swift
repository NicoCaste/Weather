//
//  ViewControllerExtension.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation
import UIKit

extension UIViewController: UIGestureRecognizerDelegate {
    // MARK: - ConfigDismissBoard
    // It recognizes the swipe up or down and hides the keyboard
    func configDismissBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToUp(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToDown(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToLeftSwipe(_:)))

        upSwipe.direction = .up
        downSwipe.direction = .down
        leftSwipe.direction = .left
        
        upSwipe.delegate = self
        downSwipe.delegate = self
        leftSwipe.delegate = self
        
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(leftSwipe)
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           true
       }

    @objc func moveToUp(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func moveToDown(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func moveToLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: getColorWeatherCondition
extension UIViewController {
    func getColorWeatherConditionFor(id: Int) -> WeatherColor {
        // default Clear
        var topColor: CGColor = makeCGColor(240, 240, 255)
        var bottomColor: CGColor = makeCGColor(65, 171, 240)
        switch id {
        //Thunderstorm
        case 200...232:
            topColor = makeCGColor(200, 200, 200)
            bottomColor = makeCGColor(1, 1, 1)
        //Drizzle
        case 300...321:
            topColor = makeCGColor(77, 167, 227)
            bottomColor = makeCGColor(60, 60, 60)
        //Rain
        case 500...531:
            topColor = makeCGColor(90, 100, 160)
            bottomColor = makeCGColor(100, 100, 100)
        //Snow
        case 600...622:
            topColor = makeCGColor(255, 255, 255)
            bottomColor = makeCGColor(186, 235, 255)
        //Mist
        case 701...781:
            topColor =  makeCGColor(194, 222, 254)
            bottomColor = makeCGColor(104, 120, 160)
        //Clouds
        case 801...804:
            topColor = makeCGColor(240, 240, 255)
            bottomColor = makeCGColor(20, 20, 20)
        default:
            break
        }
        
        return WeatherColor(topColor: topColor, bottomColor: bottomColor)
    }
    
    func makeCGColor(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat? = nil) -> CGColor {
        CGColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha ?? 1)
    }
}
