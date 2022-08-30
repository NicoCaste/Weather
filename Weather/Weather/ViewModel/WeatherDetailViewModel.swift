//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import Foundation
import UIKit

class WeatherViewModel: BaseViewModel {
    var city: Geocoding?
    var weatherForecastCardList: [WeatherForecastCard] = []
    
    func getWeatherDetailForCity(completion: @escaping() -> Void) {
        let parameters = setQueryParameter()
        callApi.getWeatherForecast(endpointType: .weather, parameters: parameters, completion:  {[weak self] result in
            switch result {
            case .success(let weather):
                if let weather = weather as? WeatherForecast {
                    let clearList = self?.clearWeatherCardList(weather: weather)
                    self?.SetImageinWeatherForecastCard(weatherList: clearList, completion: {
                        completion()
                    })
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func SetImageinWeatherForecastCard(weatherList: [WeatherAttributes]?, completion: @escaping ()-> Void) {
        guard let list = weatherList else { return }
        var index = 0
        for weather in list {
            let dayName = weather.dtTxt.getDateFormatString(format: .dayName)
            let weatherCard = WeatherForecastCard(weather: weather, weatherImage: nil, dayName: dayName)
            weatherForecastCardList.append(weatherCard)
        }
        
        for weatherCard in weatherForecastCardList {
            guard let id = weatherCard.weather?.weather?.first?.icon else { return }
            getImageBy(id: id , completion: { [weak self] imageData in
                guard let self = self, let image = UIImage(data: imageData) else { return }
                self.weatherForecastCardList[index].weatherImage = image
                index += 1
                
                if index == self.weatherForecastCardList.count {
                    completion()
                }
            })
        }
    }
    
    private func setQueryParameter() -> Parameters {
        guard let city = city else { return Parameters()}
        return Parameters(lat: city.lat, lon: city.lon)
    }
    
    func clearWeatherCardList(weather: WeatherForecast) -> [WeatherAttributes] {
        guard let weatherList = weather.list else { return [] }
        var listForDay: [WeatherAttributes] = []
        var dayList: [WeatherAttributes] = []
        var referenceDay: String?
        var detailDay: WeatherAttributes?
        
        for weather in weatherList {
            let day = weather.dtTxt.getDateFormatString(format: .day)
            
            if referenceDay == nil {
                referenceDay = day
            }
    
            if referenceDay == day {
                dayList.append(weather)
            } else {
                referenceDay = day
                
                for day in dayList {
                    if day.dtTxt.getDateFormatString(format: .hour) == "12" {
                        detailDay = day
                    }
                }
                
                if let detailDay = detailDay {
                    listForDay.append(detailDay)
                } else {
                    listForDay.append(dayList[0])
                }

                dayList = []
                dayList.append(weather)
            }
        }
        
        return listForDay
    }
}
