//
//  CityTableViewCell.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    lazy private var cityImageView: UIImageView = UIImageView()
    lazy private var cityNameLabel: UILabel = UILabel()
    lazy private var contentCityNameView: UIView = UIView()

    func populate(cityName: String) {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        setCityImageView()
        setCategoryImageView()
        setCityName(city: cityName)
    }
    
    private func setCityImageView() {
        cityImageView.image = UIImage(systemName: "mappin.circle.fill") ?? UIImage()
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cityImageView)
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.masksToBounds = true
        cityImageView.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cityImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cityImageView.heightAnchor.constraint(equalToConstant: 40),
            cityImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setCategoryImageView() {
        contentCityNameView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentCityNameView)
        contentCityNameView.layer.masksToBounds = true
        contentCityNameView.layer.cornerRadius = 4
        contentCityNameView.backgroundColor = .init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        
        NSLayoutConstraint.activate([
            contentCityNameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentCityNameView.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor),
            contentCityNameView.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 10)
        ])
    }
    
    private func setCityName(city: String) {
        cityNameLabel.text = city
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentCityNameView.addSubview(cityNameLabel)
        cityNameLabel.textColor = .white
        cityNameLabel.textAlignment = .center
        cityNameLabel.numberOfLines = 0
        cityNameLabel.font = UIFont(name: "Noto Sans Myanmar Bold", size: 15)
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentCityNameView.leadingAnchor, constant: 3),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentCityNameView.trailingAnchor, constant: -3),
            cityNameLabel.topAnchor.constraint(equalTo: contentCityNameView.topAnchor, constant: 3),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentCityNameView.bottomAnchor, constant: -3)
        ])
    }
}
