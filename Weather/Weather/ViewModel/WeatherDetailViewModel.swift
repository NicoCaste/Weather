//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import Foundation

class WeatherViewModel: BaseViewModel {
    var city: Geocoding?
    
    func getWeatherDetailForCity(completion: @escaping(WeatherForecast) -> Void) {
        let parameters = setQueryParameter()
        callApi.getWeatherForecast(endpointType: .weather, parameters: parameters, completion:  { result in
            switch result {
            case .success(let weather):
                if let weather = weather as? WeatherForecast {
                    completion(weather)
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setQueryParameter() -> Parameters {
        guard let city = city else {
            return Parameters()
        }

        return Parameters(lat: city.lat, lon: city.lon)
    }
}
