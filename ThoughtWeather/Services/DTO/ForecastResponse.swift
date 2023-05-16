// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try? JSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

// MARK: - Forecast
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [PointForecast]
    let city: City
    
    
    // MARK: - City
    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
    }
    
    // MARK: - Coord
    struct Coord: Codable {
        let lat, lon: Double
    }
    
    // MARK: - List
    struct PointForecast: Codable {
        let dt: Int
        let main: MainClass
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dtTxt: String
        let rain: Rain?
        
        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, sys
            case dtTxt = "dt_txt"
            case rain
        }
    }
    
    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int
    }
    
    // MARK: - MainClass
    struct MainClass: Codable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, seaLevel, grndLevel, humidity: Int
        let tempKf: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }
    
    // MARK: - Rain
    struct Rain: Codable {
        let the3H: Double
        
        enum CodingKeys: String, CodingKey {
            case the3H = "3h"
        }
    }
    
    // MARK: - Sys
    struct Sys: Codable {
        let pod: Pod
    }
    
    enum Pod: String, Codable {
        case d = "d"
        case n = "n"
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let id: Int
        let main: MainEnum
        let description: String
        let icon: String
    }
    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
    
    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
}
