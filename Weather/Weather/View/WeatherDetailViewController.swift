//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    let city: Geocoding
    var viewModel: WeatherViewModel?
    lazy var cityNameLabel: UILabel = UILabel() 
    lazy var tableView: UITableView = UITableView()
    
    init(city: Geocoding) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.title =  "Weather Forecast"
        configViewModel()
        getWeatherDetailForCity()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum WeatherDetailSections: Int, CaseIterable {
        case weatherToday
        case extendedForecast
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCityNameLabel()
        setTableView()
    }
    
    func configViewModel() {
        viewModel = WeatherViewModel()
        viewModel?.city = city
    }
    
    //MARK: CityNameLabel
    private func setCityNameLabel() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.text = city.name
        view.addSubview(cityNameLabel)
        
        cityNameLabel.font = UIFont(name: "Noto Sans Myanmar Bold", size: 30)
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // MARK: - TableView
    private func setTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.separatorStyle = .none
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        layoutTableView()
    }
    
    // MARK: - Layout TableView
    func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getWeatherDetailForCity() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.viewModel?.getWeatherDetailForCity(completion: {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
        }
    }
}

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        WeatherDetailSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.weatherForecastCardList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
