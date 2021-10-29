
import Foundation
import CoreLocation

struct WeatherLoader{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=99ebdd65f69f1233a43df978742659b2&units=metric"
    
    static var lat: Double = 0.0
    static var lon: Double = 0.0
    static var weatherData: WeatherData?
    static var weatherWeekData: WeatherWeekData?
    //&lang=ru
    
    func loadWeather(cityName: String,completion: @escaping (WeatherData) -> Void){
        let urlString = "\(weatherURL)&q=\(cityName)"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(WeatherData.self, from: safeData)
                        WeatherLoader.lat = decodeData.coord.lat
                        WeatherLoader.lon = decodeData.coord.lon
                        WeatherLoader.weatherData = decodeData
                        WeatherLoader.weatherWeekData = nil
                        DispatchQueue.main.async {
                            completion(decodeData)
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            }
            task.resume()
        }
    }
    func loadWeather7days(latitude: CLLocationDegrees, longitude: CLLocationDegrees,completion: @escaping (WeatherWeekData) -> Void){
        let weather7URL = "https://api.openweathermap.org/data/2.5/onecall?appid=99ebdd65f69f1233a43df978742659b2&units=metric"
        let urlString = "\(weather7URL)&lat=\(latitude)&lon=\(longitude)"//&exclude=daily
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodeData = try decoder.decode(WeatherWeekData.self, from: safeData)
                        DispatchQueue.main.async {
                            completion(decodeData)
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
}
