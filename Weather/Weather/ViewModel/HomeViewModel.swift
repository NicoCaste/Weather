//
//  HomeViewModel.swift
//  Weather
//
//  Created by nicolas castello on 29/08/2022.
//

import Foundation

class HomeViewModel: BaseViewModel {
    let notificationCenter = NotificationCenter.default
    private let key = "savedCity"
    override init() {
        super.init()
    }
    
    func getCitiesSaved() -> Set<Geocoding>? {
        var selectedCities: Set<Geocoding>?
        UserDefaults.standard.synchronize()
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            selectedCities = try? PropertyListDecoder().decode(Set<Geocoding>.self, from: data)
        }
        
        return selectedCities
        
    }
    
    func saveNewCity(city: Geocoding) {
        var selectedCities: Set<Geocoding?> = []
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            guard let cities = try? PropertyListDecoder().decode(Set<Geocoding>.self, from: data) else { return }
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.synchronize()
            selectedCities = cities
        }
        
        selectedCities.update(with: city)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(selectedCities), forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func removeCity(city: Geocoding) {
        var selectedCities: Set<Geocoding?> = []
        UserDefaults.standard.synchronize()
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            guard let cities = try? PropertyListDecoder().decode(Set<Geocoding>.self, from: data) else { return }
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.synchronize()
            selectedCities = cities
        }
        
        let findCity = selectedCities.firstIndex(where: { $0 == city })
        if let findCity = findCity {
            selectedCities.remove(at: findCity)
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(selectedCities), forKey: key)
        UserDefaults.standard.synchronize()
    }
}
