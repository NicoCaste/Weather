//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    let city: Geocoding
    var viewModel: WeatherViewModel?
    
    init(city: Geocoding) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
        configViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getWeatherDetailForCity(completion: { weather in
            print(weather)
        })
    }
    
    func configViewModel() {
        viewModel = WeatherViewModel()
        viewModel?.city = city
    }
}
