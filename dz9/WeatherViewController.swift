//
//  WeatherViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 29.10.2021.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = RealmDatabaseWeather.shared.loadWeather().first {
            self.tempLabel.text = String(format: "%.1f",result.temp)
            self.cityLabel.text = result.city
            WeatherLoader().loadWeather(cityName: result.city) { results in
                self.tempLabel.text = String(format: "%.1f", results.main.temp)
                self.cityLabel.text = results.name
                RealmDatabaseWeather.shared.saveWeather()
                //так как в задаче написано что надо сделать сразу запрос на новые данные
                //а в другом было что мы загружаем список еще одним запросом
                //то после обновления данных текущий я сбрасываю предположительные
                //и уже старые данные на 5 не загрузятся
                //т к если тут будут новые, а там отвалится интернет и загрузятся старые
                //ну это будет ужасно
            }
        } else {
            WeatherLoader().loadWeather(cityName: "Vyborg") { results in
                self.tempLabel.text = String(format: "%.1f", results.main.temp)
                self.cityLabel.text = results.name
                RealmDatabaseWeather.shared.saveWeather()
            }
        }
        
        
        
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if let city = searchTextField.text {
            WeatherLoader().loadWeather(cityName: city) { results in
                self.tempLabel.text = String(format: "%.1f", results.main.temp)
                self.cityLabel.text = results.name
                RealmDatabaseWeather.shared.saveWeather()
            }
        }
    }
    
}
