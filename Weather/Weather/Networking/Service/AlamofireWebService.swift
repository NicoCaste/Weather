//
//  AlamofireWebService.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation
import Alamofire

final class AlamofireWebService: WebService {
    private let apiKey: String = ApiKeyManager.getOpenWeatherApiKey() ?? ""
    
    func get(_ urlString: String, parameters: Parameters, completion: @escaping (Result<Data, Error>) -> Void) {
        var params = parameters
        params.appid = apiKey
        AF.request(urlString, parameters: params).responseData { response in
           
            if let data = response.value {
                if response.response?.statusCode == 200 {                    completion(.success(data))
                } else {
                    completion(.failure(WeatherApiError.notFound))
                }
            } else if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.failure(WeatherApiError.unexpected(code: 0)))
            }
        }
    }
    
    func post(_ urlString: String, parameters: Parameters, completion: @escaping (Result<Data, Error>) -> Void) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(parameters),
              let url = URL(string: urlString)
        else { return }
        
        var urlRequest = URLRequest(url: url)
        let headers: HTTPHeaders = [.authorization(bearerToken: apiKey), .contentType("application/json")]
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        urlRequest.headers = headers
        urlRequest.httpMethod = "POST"
        
        AF.request(urlRequest).responseData { response in
            if let data = response.value {
                completion(.success(data))
            } else if let error = response.error {
                completion(.failure(error))
            } else {
                print("error desconocido")
            }
        }
    }
}


enum WeatherApiError: Error {
    // Throw when an invalid password is entered
    case invalidPassword
    // Throw when an expected resource is not found
    case notFound
    // Throw in all other cases
    case unexpected(code: Int)
}
