//
//  Double+Extensions.swift
//  WeatherAppMVVM
//
//  Created by Yassine DAOUDI on 1/27/20.
//  Copyright © 2020 Yassine DAOUDI. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        return String(format: "%.0f",self)
    }
}
