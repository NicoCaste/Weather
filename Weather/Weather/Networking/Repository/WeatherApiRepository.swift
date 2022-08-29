//
//  WeatherApiRepository.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

final class WeatherApiRepository {
    var webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func getWeatherForecast(parameters: Parameters, completion: @escaping (Result<WeatherForecast, Error>) -> Void) {
        let url = ApiUrlHelper.getApiUrl(call: .weather)
        webService.get(url, parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                   let weatherForecast = try JSONDecoder().decode(WeatherForecast.self, from: data)
                   completion(.success(weatherForecast))
                } catch {
                   completion(.failure(error))
                }
            case .failure(let error):
               completion(.failure(error))
                break
            }
        })
    }
}
