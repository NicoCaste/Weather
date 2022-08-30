//
//  ViewController.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var headerView: HeaderView = HeaderView(frame: self.view.frame)
    lazy var searchView: SearchMovieView = SearchMovieView(frame: self.view.frame)
    lazy var citiesListView: CitiesListView = CitiesListView(frame: self.view.frame)
    var viewModel: HomeViewModel?
    var weatherColor: WeatherColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        weatherColor = getColorWeatherConditionFor(id: 800)
        self.view.gradientBackground(topColor: weatherColor!.topColor, bottomColor: weatherColor!.bottomColor)
        self.configDismissBoard()
        setHeaderView()
        setSearchView()
        setCitiesListView()
    }
    
    func setSearchView() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchView)
        searchView.delegate = self
        if let weatherColor = weatherColor {
            searchView.setTextField(colors: weatherColor)
        }
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)
        headerView.goToSearch = goToSearchView
        headerView.setHeaderFont(color: weatherColor?.headerColor)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setCitiesListView() {
       // citiesListView.delegate = self
        citiesListView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(citiesListView)
        citiesListView.delegate = self
        NSLayoutConstraint.activate([
            citiesListView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            citiesListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            citiesListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            citiesListView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension HomeViewController: SearchMovieViewProtocol {
    func goToSearchView() {
        DispatchQueue.main.async {
            self.headerView.removeFromSuperview()
            self.setSearchView()
            self.citiesListView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor).isActive = true
            self.view.layoutSubviews()
        }
    }
    
    func closeSearchView() {
        DispatchQueue.main.async {
            self.searchView.removeFromSuperview()
            self.setHeaderView()
            self.citiesListView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
            self.view.layoutSubviews()
        }
    }
}

extension HomeViewController: CitiesListViewProtocol {
    
    func getCitiesSaved() -> Set<Geocoding>? {
        viewModel?.getCitiesSaved()
    }
    
    func saveNewCity(city: Geocoding) {
        viewModel?.saveNewCity(city: city)
    }
    
    func removeCity(city: Geocoding) {
        viewModel?.removeCity(city: city)
    }
    
    func goToWeatherDetail(city: Geocoding) {
        print(city.name)
    }
    
    
}

