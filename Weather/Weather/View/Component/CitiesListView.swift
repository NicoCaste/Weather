//
//  CitiesListView.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation
import UIKit

protocol CitiesListViewProtocol {
    func getCitiesSaved() -> Set<Geocoding>?
    func saveNewCity(city: Geocoding)
    func removeCity(city: Geocoding)
    func goToWeatherDetail(city: Geocoding)
}

class CitiesListView: UIView {
    lazy var tableView: UITableView = UITableView()
    let notificationCenter = NotificationCenter.default
    private var citySections: String = ""
    private var savedCities = Set<Geocoding>.init()
    private var tableContent: [Geocoding] = []
    var delegate: CitiesListViewProtocol?
    var firstLoad: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setTableView()
        getCitiesSaved()
        notificationCenter.addObserver(self, selector: #selector(clearPrediciton), name: NSNotification.Name.clearPrediction, object: nil)
        notificationCenter.addObserver(self, selector: #selector(citiesPrediction), name: NSNotification.Name.newCity, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        notificationCenter.removeObserver(self, name: NSNotification.Name.clearPrediction, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.newCity, object: nil)
    }
    
    enum CitiesSections: String {
        case prediction = "prediction list"
        case saved = "My Cities"
    }
    
    @objc func citiesPrediction(notification: Notification) {
        guard let cities = notification.userInfo?[ApiCall.geocoding.rawValue] as? [Geocoding] else { return }
        setSection(section: .prediction)
        tableContent = cities
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc func clearPrediciton() {
        if !savedCities.isEmpty {
            tableContent = Array(savedCities)
            setSection(section: .saved)
        } else {
            tableContent = []
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func getCitiesSaved() {
        savedCities = delegate?.getCitiesSaved() ?? []
        if !savedCities.isEmpty {
            setSection(section: .saved)
        }
        tableContent = Array(savedCities)
    }
    
    private func reloadSavedCities() {
        DispatchQueue.main.async { [weak self] in
            self?.getCitiesSaved()
            self?.setSection(section: .saved)
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - TableView
    private func setTableView() {
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableView)
        layoutTableView()
    }
    
    // MARK: - Layout TableView
    func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    // MARK: - Add Subs Section
    func setSection(section: CitiesSections) {
        citySections = section.rawValue
    }

}

extension CitiesListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return citySections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if firstLoad {
            firstLoad = false
            getCitiesSaved()
        }
        return tableContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as? CityTableViewCell
        cell?.populate(cityName: tableContent[indexPath.row].name ?? "")
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let citySelected = tableContent[indexPath.row]
        if savedCities.contains(citySelected) {
            delegate?.goToWeatherDetail(city: citySelected)
        } else {
            delegate?.saveNewCity(city: citySelected)
            reloadSavedCities()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let currentCity = tableContent[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "delete".localized(), handler: {[weak self] _,_,_ in
            self?.delegate?.removeCity(city: currentCity)
            self?.reloadSavedCities()
            })
            deleteAction.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
