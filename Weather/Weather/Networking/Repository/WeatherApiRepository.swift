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
    
    func getWeatherForecast(endpointType: ApiCall, parameters: Parameters, completion: @escaping (Result<Decodable, Error>) -> Void) {
        let url = ApiUrlHelper.getApiUrl(call: endpointType)

        webService.get(url, parameters: parameters, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleSuccessBlock(endpointType: endpointType, data: data, completion: { response in
                        completion(response)
                })
            case .failure(let error):
               completion(.failure(error))
            }
        })
    }
    
    private func handleSuccessBlock (endpointType: ApiCall, data: Data, completion: @escaping (Result<Decodable, Error>) -> Void) {
        let response = getDecodableResponse(endpoint: endpointType, data: data)
        
        switch endpointType {
        case .weather:
            if let weather = response as? WeatherForecast {
                completion(.success(weather))
            } else {
                completion(.failure(WeatherApiError.unexpected(code: 1)))
            }
        case .geocoding:
            if let geocodin = response as? [Geocoding] {
                completion(.success(geocodin))
            } else {
                completion(.failure(WeatherApiError.unexpected(code: 2)))
            }
        }
    }
    
    private func getDecodableResponse(endpoint: ApiCall, data: Data) -> Decodable {
        switch endpoint {
        case .weather:
            do {
                let weather: WeatherForecast = try data.decodedObject()
                return weather
            } catch {
                return WeatherForecast()
            }
        case .geocoding:
            do {
                let geocodin: [Geocoding] = try data.decodedObject()
                return geocodin
            } catch {
                return Geocoding()
            }
        }
    }
}

extension Data {
    func decodedObject<T: Decodable>() throws -> T {
        try JSONDecoder().decode(T.self, from: self)
    }
}
