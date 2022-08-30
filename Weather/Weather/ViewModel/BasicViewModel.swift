//
//  BasicViewModel.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation

class BaseViewModel {
    let service: AlamofireWebService
    let callApi: WeatherApiRepository
    
    init() {
        self.service = AlamofireWebService()
        self.callApi = WeatherApiRepository(webService: service)
    }
    
    func getImageBy(id: String, completion:@escaping(Data) -> Void) {
        let url = ApiUrlHelper.getApiUrl(call: .image, imageId: id)
        callApi.getWeatherForecast(url: url, endpointType: .image, parameters: Parameters(), completion: { result in
            switch result {
            case .success(let imageData):
                if let imageData = imageData as? Data {
                    completion(imageData)
                } else {
                    print("error de formato")
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
