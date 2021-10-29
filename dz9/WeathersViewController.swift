//
//  WeathersViewController.swift
//  dz9
//
//  Created by Андрей Адельбергис on 29.10.2021.
//

import UIKit
//import CoreLocation

class WeathersViewController: UIViewController {

    
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var weathers: [Daily] = []
    
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    var weatherViewController = WeatherViewController()
    
    //let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //locationManager.delegate = self
        
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.requestLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if lat != WeatherLoader.lat || lon != WeatherLoader.lon {
            lat = WeatherLoader.lat
            lon = WeatherLoader.lon
            coordinateLabel.text = "\(lat) : \(lon)"
            WeatherLoader().loadWeather7days(latitude: lat, longitude: lon) { results in
                self.weathers = results.daily
                self.tableView.reloadData()
                RealmDatabaseWeather.shared.saveWeather()
            }
        }
    }
    
}
//extension WeathersViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print("Текущее местоположение \(location)")
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            print(lat)
//            print(lon)
//            WeatherLoader().loadWeather7days(latitude: lat, longitude: lon) { results in
//                self.weathers = results.daily
//                self.tableView.reloadData()
//            }
//        }
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location \(error.localizedDescription)")
//    }
//}

extension WeathersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count - 3 // ну нужно только на 5 дней)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatherCell") as! WeatherTableViewCell
        
        let model = weathers[indexPath.row]
        cell.dateLabel.text = "\(Calendar.current.component(.day, from: model.dt)).\(Calendar.current.component(.month, from: model.dt))"
        cell.tempLabel.text = String(format: "%.1f",model.temp.day)
        return cell
    }
    
    
}

