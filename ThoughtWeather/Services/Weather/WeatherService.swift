//
//  WeatherService.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-17.
//

import Foundation

protocol WeatherServiceType {
    func getForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast
}

enum WeatherServiceError: Error {
    case noResponse
}

class WeatherService: WeatherServiceType {
    func getForecast(latitude: Double, longitude: Double) async throws -> WeatherForecast {
        guard let forecastResponse = try await WeatherClient().getForecast(latitude: latitude, longitude: longitude) else {
            throw WeatherServiceError.noResponse
        }
        
        return WeatherForecast(forecastResponse: forecastResponse)
    }
}
