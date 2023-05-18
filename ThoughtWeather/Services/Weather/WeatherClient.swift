//
//  WeatherClient.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-17.
//

import Foundation

class WeatherClient: WeatherClientType {
    func getForecast(latitude: Double, longitude: Double) async throws -> ForecastResponse? {
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

        return try JSONDecoder().decode(ForecastResponse.self, from: data)
    }
}
