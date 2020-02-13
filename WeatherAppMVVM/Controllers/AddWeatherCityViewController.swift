//
//  AddWeatherCityViewController.swift
//  WeatherAppMVVM
//
//  Created by Yassine DAOUDI on 1/24/20.
//  Copyright © 2020 Yassine DAOUDI. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel)
}
class AddWeatherCityViewController: UIViewController {
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind {
                self.addCityViewModel.city = $0
            }
        }
    }
    
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            stateTextField.bind {
                self.addCityViewModel.state = $0
            }
        }
    }
    
    @IBOutlet weak var zipCodeTextField: BindingTextField! {
        didSet {
            zipCodeTextField.bind {
                self.addCityViewModel.zipCode = $0
            }
        }
    }
    
    var delegate: AddWeatherDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        print(self.addCityViewModel)
        
        if let city = cityNameTextField.text {
            
            let userDefaults = UserDefaults.standard
            let unit = userDefaults.value(forKey: "unit") as! String
            
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=eeb6a5b00a72a602b2b084e31acaf86c&units=\(unit)")!
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                
                return weatherVM
            }
            
            Webservice().load(resource: weatherResource) { result in
                if let weatherVM = result {
                    if let delegate = self.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
