// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try? JSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

// MARK: - Forecast
struct ForecastResponse: Codable {
    let timeForecasts: [TimeForecast]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case timeForecasts = "list"
        case city
    }
    
    // MARK: - City
    struct City: Codable {
        let id: Int
        let name: String
    }
    
    // MARK: - TimeForecast
    // One record for each three-hour interval over the next five days.
    struct TimeForecast: Codable {
        let dt: Int // UNIX date for this record
        let temperatures: Temperatures
        let weather: [Weather] // can remove later
        let dtTxt: String // can remove later
        
        enum CodingKeys: String, CodingKey {
            case dt
            case temperatures = "main"
            case dtTxt = "dt_txt"
            case weather
        }
    }
    
    // MARK: - MainClass
    struct Temperatures: Codable {
        let temp, tempMin, tempMax: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    // MARK: - Weather
    // Can remove later
    struct Weather: Codable {
        let id: Int
        let main: MainEnum
        let description: String
        let icon: String
    }

    // can remove later
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
}
