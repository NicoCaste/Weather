//
//  ExtendedForecastTableViewCell.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import UIKit

class ExtendedForecastTableViewCell: UITableViewCell {
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
        if let id = weatherCardDetail?.weather?.weather?.first?.id {
            setBackgroundColor(id: id)
        }
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
            weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            weatherImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            weatherImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setDayNameLabel() {
        guard let weatherCardDetail = weatherCardDetail else { return }
        dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayNameLabel)
        dayNameLabel.text = weatherCardDetail.dayName ?? ""
        dayNameLabel.textColor = .black
        dayNameLabel.textAlignment = .left
        dayNameLabel.font = UIFont(name: "Noto Sans Myanmar Bold", size: 18)
        
        NSLayoutConstraint.activate([
            dayNameLabel.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            dayNameLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 10),
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
        currentTemp.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        
        NSLayoutConstraint.activate([
            currentTemp.leadingAnchor.constraint(equalTo: dayNameLabel.trailingAnchor, constant: 5),
            currentTemp.centerYAnchor.constraint(equalTo: dayNameLabel.centerYAnchor)
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
        tempMax.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        tempMax.textAlignment = .right
        
        NSLayoutConstraint.activate([
            tempMax.leadingAnchor.constraint(equalTo: currentTemp.trailingAnchor, constant: 5),
            tempMax.centerYAnchor.constraint(equalTo: currentTemp.centerYAnchor)
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
        tempMin.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        tempMin.textAlignment = .right
        
        NSLayoutConstraint.activate([
            tempMin.centerYAnchor.constraint(equalTo: tempMax.centerYAnchor),
            tempMin.leadingAnchor.constraint(equalTo: tempMax.trailingAnchor),
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
            probabilityOfPrecipitation.attributedText = popString.setStringWithImageAttachment(imageName: "cloud.heavyrain", imageSize: 15)
        } else {
            probabilityOfPrecipitation.text = ""
        }
        
        probabilityOfPrecipitation.textAlignment = .left
        probabilityOfPrecipitation.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        
        NSLayoutConstraint.activate([
            probabilityOfPrecipitation.centerYAnchor.constraint(equalTo: tempMin.centerYAnchor),
            probabilityOfPrecipitation.leadingAnchor.constraint(equalTo: tempMin.trailingAnchor, constant: 10),
            probabilityOfPrecipitation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)

    }
    
    func setBackgroundColor(id: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let weatherColor = self?.contentView.getColorWeatherConditionFor(id: id) else { return }
            let top = weatherColor.topColor.copy(alpha: 0.8)
            let bottom = weatherColor.bottomColor.copy(alpha: 0.8)
            self?.gradientBackground(topColor: top ?? weatherColor.topColor, bottomColor: bottom ?? weatherColor.bottomColor)
        }
    }
}
