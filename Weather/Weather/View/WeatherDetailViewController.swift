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
    lazy var activityIndicator: UIActivityIndicatorView? = UIActivityIndicatorView(style: .large)
    lazy var cityNameLabel: UILabel = UILabel() 
    lazy var tableView: UITableView = UITableView()
    var notificationCenter: NotificationCenter = NotificationCenter.default
    
    init(city: Geocoding) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.title =  "wForecast".localized()
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
        setActivityIndicator()
        notificationCenter.addObserver(self, selector: #selector(showErrorView(_:)), name: NSNotification.Name.showErrorView, object: nil)
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
        tableView.isHidden = true
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.userActivity = .none
        tableView.register(WeatherMainDetailTableViewCell.self, forCellReuseIdentifier: "WeatherMainDetailTableViewCell")
        tableView.register(ExtendedForecastTableViewCell.self, forCellReuseIdentifier: "ExtendedForecastTableViewCell")
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
                    self?.stopActivityIndicator()
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    func setBackgroundColor(id: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let weatherColor = self?.view.getColorWeatherConditionFor(id: id) else { return }
            self?.view.gradientBackground(topColor: weatherColor.topColor, bottomColor: weatherColor.bottomColor)
            self?.cityNameLabel.textColor = weatherColor.headerColor
        }
    }
    
    // MARK: - SetActivityIndicator
    func setActivityIndicator() {
        activityIndicator?.color = .systemGray
        guard let activityIndicator = activityIndicator else { return }
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    // MARK: - StopActivity
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.removeFromSuperview()
        }
    }
    
    @objc func showErrorView(_ error: Notification) {
        guard let errorMessage = error.userInfo?["errorMessage"] as? ErrorMessage,
              let navigation = self.navigationController else { return }
        Router.showErrorView(navigation: navigation, message: errorMessage )

    }
}

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        WeatherDetailSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        if WeatherDetailSections.weatherToday.rawValue == section {
            return 1
        } else {
            return viewModel.weatherForecastCardList.count - 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = UITableViewCell()
        emptyCell.widthAnchor.constraint(equalToConstant: 0)
        
        if WeatherDetailSections.weatherToday.rawValue == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherMainDetailTableViewCell") as? WeatherMainDetailTableViewCell
            
            guard let weather =  viewModel?.weatherForecastCardList.first else { return UITableViewCell() }
            
            cell?.populate(weatherCard: weather)
            
            if let id = weather.weather?.weather?.first?.id {
                setBackgroundColor(id: id)
            }
            
            return cell ?? emptyCell
        } else if WeatherDetailSections.extendedForecast.rawValue == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExtendedForecastTableViewCell") as? ExtendedForecastTableViewCell
            
            guard let weather = viewModel?.weatherForecastCardList[indexPath.row + 1] else { return emptyCell }
            
            cell?.populate(weatherCard: weather)
            
            return cell ?? emptyCell
        }
        
        return emptyCell
    }
}
