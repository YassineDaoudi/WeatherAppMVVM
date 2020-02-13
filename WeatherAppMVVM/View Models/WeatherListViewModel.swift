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
            
            let weatherModel = vm
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value - 32) * 5/9
            return weatherModel
            
        }
        
    }
    
    mutating private func toFahrenheit() {
        
        weatherViewModels = weatherViewModels.map { vm in
            
            let weatherModel = vm
            weatherModel.currentTemperature.temperature.value = (weatherModel.currentTemperature.temperature.value * 5/9) + 32
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

// Type Eraser
class Dynamic<T>: Decodable where T: Decodable {
    typealias Listener = (T) -> ()
    var listner: Listener?
    
    var value: T {
        didSet{
            listner?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listner = listener
        self.listner?(self.value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct WeatherViewModel: Decodable {
    
    let name: Dynamic<String>
    var currentTemperature: TemperatureViewModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
}

struct TemperatureViewModel: Decodable {
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
