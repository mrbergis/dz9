import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}

struct Coord:Decodable {
    let lon: Double
    let lat: Double
}

struct WeatherWeekData: Decodable {
    let daily: [Daily]
}

struct Daily: Decodable {
    let dt: Date
    let temp: Temp
}

struct Temp: Decodable{
    let day: Double
}
