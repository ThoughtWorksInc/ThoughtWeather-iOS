// This file was generated from JSON Schema using quicktype.io.
// It's based on the schema returned by https://api.openweathermap.org/data/2.5/forecast?lat=[latitude]&lon=[longitude]&appid=[appId]

// ForecastResponse is a DTO representing the weather-forecast response from OpenWeather.
// This struct's only job is to tell the application how to deserialize the forecast response.
// Responses are transformed into WeatherForecast structs by the WeatherService class,
// and those WeatherForecast structs are pure domain objects which can be used by the application.

import Foundation

// MARK: - ForecastResponse
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
