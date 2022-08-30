//
//  SearchViewModel.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation
import UIKit

class SearchViewModel: BaseViewModel {
    private var searchTimer: Timer?
    private var timeInterval = 0.8
    
    func findCityFor(name: String) {
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }

        searchTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(getArtist(_:)), userInfo: name, repeats: false)
    }
    
   @objc private func getArtist(_ timer: Timer) {
        guard let title: String = timer.userInfo as? String else { return }
       getGeocodingFor(text: title)
    }
    
    func getGeocodingFor(text: String) {
        let parameters = setQueryParameter(text: text)
        callApi.getWeatherForecast(endpointType: .geocoding, parameters: parameters, completion: { result in
            switch result {
            case .success(let cities):
                if let cities = cities as? [Geocoding] {
                    let userInfo: [String : Any] = [ApiCall.geocoding.rawValue : cities]
                    NotificationCenter.default.post(name: NSNotification.Name.newCity, object: nil, userInfo: userInfo)
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setQueryParameter(text: String) -> Parameters {
        return Parameters(q: text, limit: 5)
    }
}
