//
//  WeatherListViewModel.swift
//  WeatherAppMVVM
//
//  Created by Yassine DAOUDI on 1/24/20.
//  Copyright © 2020 Yassine DAOUDI. All rights reserved.
//

import Foundation

struct WeatherListViewModel {
    
    private var weatherViewModels = [WeatherViewModel]()
    
    mutating func addWeatherViewModel(_ vm: WeatherViewModel) {
        self.weatherViewModels.append(vm)
    }
    
    func numberofRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return self.weatherViewModels[index ]
    }
    
    mutating private func toCelsius() {
        
        weatherViewModels = weatherViewModels.map { vm in
            
            var weatherModel = vm
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature - 32) * 5/9
            return weatherModel
            
        }
        
    }
    
    mutating private func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { vm in
            
            var weatherModel = vm
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature * 5/9) + 32
            return weatherModel
            
        }
        
    }
    
    mutating func updateUnit(to unit: Unit) {
        
        switch unit {
        case .celsius:
            toCelsius()
        case .fahrenheit:
            toFahrenheit()
        }
    }
}


struct WeatherViewModel: Decodable {
    
    let name: String
    var currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable {
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
