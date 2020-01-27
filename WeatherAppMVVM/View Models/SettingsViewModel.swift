//
//  SettingsViewModel.swift
//  WeatherAppMVVM
//
//  Created by Yassine DAOUDI on 1/27/20.
//  Copyright © 2020 Yassine DAOUDI. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    
    var displayName: String {
        get {
            switch(self) {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    
    let units = Unit.allCases
}
