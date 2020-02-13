//
//  WeatherDetailsViewController.swift
//  WeatherAppMVVM
//
//  Created by Yassine DAOUDI on 2/13/20.
//  Copyright © 2020 Yassine DAOUDI. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVMBindings()
    }
    
    func setupVMBindings() {
        
        if let weatherVM = self.weatherViewModel {
            
            weatherVM.name.bind { self.cityNameLabel.text = $0 }
            weatherVM.currentTemperature.temperature.bind { self.currentTempLabel.text = $0.formatAsDegree }
            weatherVM.currentTemperature.temperatureMax.bind { self.maxTempLabel.text = $0.formatAsDegree }
            weatherVM.currentTemperature.temperatureMin.bind { self.minTempLabel.text = $0.formatAsDegree }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
