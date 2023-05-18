//
//  WeatherClient.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-17.
//

import Foundation

// WeatherClient requests the five-day forecast for the specified location.
// That forecast is returned in a response DTO of type ForecastResponse, which mirrors the JSON payload.
// WeatherClient then transforms the ForecastResponse to a WeatherForecast domain object and returns it.
// Note the reference to Config.appId - there's a place in Config.swift to add your API key
//   (as well as instructions on where to get that key).
class WeatherClient: WeatherClientType {
    func getForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast? {
        let urlString = [
                    "https://api.openweathermap.org/data/2.5/forecast",
                    "?lat=\(latitude)",
                    "&lon=\(longitude)",
                    "&appid=\(Config.appId)"
        ].joined()
        
        guard let url = URL(string: urlString) else {
            fatalError("Could not resolve OpenWeatherMap URL from \(urlString)")
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let forecastResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
        return WeatherForecast(forecastResponse: forecastResponse)
    }
}
