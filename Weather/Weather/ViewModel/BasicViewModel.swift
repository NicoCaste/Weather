//
//  BasicViewModel.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation
import UIKit

class BaseViewModel {
    let service: AlamofireWebService
    let callApi: WeatherApiRepository
    
    init() {
        self.service = AlamofireWebService()
        self.callApi = WeatherApiRepository(webService: service)
    }
    
    func getImageBy(id: String, completion:@escaping(Data) -> Void) {
        let url = ApiUrlHelper.getApiUrl(call: .image, imageId: id)
        callApi.getWeatherForecast(url: url, endpointType: .image, parameters: Parameters(), completion: {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imageData):
                if let imageData = imageData as? Data {
                    completion(imageData)
                } else {
                    let genericImage = self.genericImageData()
                    completion(genericImage)
                }
            case .failure(let error):
                let genericImage = self.genericImageData()
                completion(genericImage)
            }
        })
    }
    
    private func genericImageData() -> Data {
        guard let imageCamera = UIImage(systemName: "camera"),
              let imageData = imageCamera.pngData()
        else { return Data()}
        return imageData
    }
}
