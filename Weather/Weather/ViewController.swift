//
//  ViewController.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var service: AlamofireWebService?
    var callApi: WeatherApiRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}

