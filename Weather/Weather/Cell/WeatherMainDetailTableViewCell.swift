//
//  WeatherMainDetailTableViewCell.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import UIKit

class WeatherMainDetailTableViewCell: UITableViewCell {
    lazy private var weatherImage: UIImageView = UIImageView()
    lazy private var dayNameLabel: UILabel = UILabel()
    lazy private var tempMin: UILabel = UILabel()
    lazy private var tempMax: UILabel = UILabel()
    lazy private var currentTemp: UILabel = UILabel()
    lazy private var probabilityOfPrecipitation: UILabel = UILabel()
    
    private var weatherCardDetail: WeatherForecastCard?
    
    func populate(weatherCard: WeatherForecastCard) {
        self.backgroundColor = .clear
        self.weatherCardDetail = weatherCard
        setWeatherImage()
        setDayNameLabel()
        setCurrentTemp()
        setTempMax()
        setTempMin()
        setprobabilityOfPrecipitation()
    }
    
    func setWeatherImage() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        weatherImage.image = weatherCardDetail.weatherImage
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weatherImage)
        weatherImage.layer.masksToBounds = true
        weatherImage.layer.cornerRadius = 45
        
        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 90),
            weatherImage.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setDayNameLabel() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayNameLabel)
        dayNameLabel.text = weatherCardDetail.dayName ?? ""
        dayNameLabel.textColor = .black
        dayNameLabel.textAlignment = .left
        dayNameLabel.font = UIFont(name: "Noto Sans Myanmar Bold", size: 25)
        
        NSLayoutConstraint.activate([
            dayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dayNameLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 10),
            dayNameLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func setCurrentTemp() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        currentTemp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(currentTemp)
        let temperature = weatherCardDetail.weather?.main?.temp?.fromKelvinToCelcius()
        let temp = Int(temperature ?? 0)
        let tempString: String = temp.description
        currentTemp.text = (temperature != nil) ? tempString + "°" : ""
        currentTemp.textColor = .black
        currentTemp.font = UIFont(name: "Noto Sans Myanmar Bold", size: 40)
        
        NSLayoutConstraint.activate([
            currentTemp.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 10),
            currentTemp.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor),
            currentTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            currentTemp.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func setTempMax() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        tempMax.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tempMax)
        let temperature = weatherCardDetail.weather?.main?.tempMax?.fromKelvinToCelcius()
        let tempH = Int(temperature ?? 0)
        let tempHString: String = tempH.description
        tempMax.text = (temperature != nil) ? "H: \(tempHString)°" : ""
        tempMax.font = UIFont(name: "Noto Sans Myanmar Bold", size: 20)
        tempMax.textAlignment = .right
        
        NSLayoutConstraint.activate([
            tempMax.leadingAnchor.constraint(equalTo: dayNameLabel.trailingAnchor, constant: 10),
            tempMax.heightAnchor.constraint(equalTo: dayNameLabel.heightAnchor),
            tempMax.centerYAnchor.constraint(equalTo: dayNameLabel.centerYAnchor),
            tempMax.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
    }
    
    func setTempMin() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        tempMin.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tempMin)
        let temperature = weatherCardDetail.weather?.main?.tempMin?.fromKelvinToCelcius()
        let tempL = Int(temperature ?? 0)
        let tempLString: String = tempL.description
        tempMin.text = (temperature != nil) ? "L: \(tempLString)°" : ""
        tempMin.font = UIFont(name: "Noto Sans Myanmar Bold", size: 20)
        tempMin.textAlignment = .right
        
        NSLayoutConstraint.activate([
            tempMin.topAnchor.constraint(equalTo: tempMax.bottomAnchor, constant: 5),
            tempMin.centerXAnchor.constraint(equalTo: tempMax.centerXAnchor),
            tempMin.widthAnchor.constraint(equalTo: tempMax.widthAnchor)
        ])
    }
    
    func setprobabilityOfPrecipitation() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        probabilityOfPrecipitation.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(probabilityOfPrecipitation)
        let pop =  weatherCardDetail.weather?.pop
        let probability = (pop ?? 0) * 100
        var popString: String = probability.description
        if pop != nil {
            popString = " \(popString)%"
            probabilityOfPrecipitation.attributedText = popString.setStringWithImageAttachment(imageName: "cloud.heavyrain", imageSize: 23)
        } else {
            probabilityOfPrecipitation.text = ""
        }
        
        probabilityOfPrecipitation.textAlignment = .left
        probabilityOfPrecipitation.font = UIFont(name: "Noto Sans Myanmar Bold", size: 17)
        
        NSLayoutConstraint.activate([
            probabilityOfPrecipitation.centerYAnchor.constraint(equalTo: currentTemp.centerYAnchor),
            probabilityOfPrecipitation.leadingAnchor.constraint(equalTo: currentTemp.trailingAnchor, constant: 10),
            probabilityOfPrecipitation.trailingAnchor.constraint(equalTo: tempMin.leadingAnchor, constant: -10)
        ])
    }
}
