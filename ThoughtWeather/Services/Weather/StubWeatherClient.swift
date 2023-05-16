//
//  StubWeatherClient.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation

class StubWeatherClient: WeatherClientType {
    func getCurrentConditions(latitude: Double, longitude: Double) async -> CurrentConditionsResponse? {
        return StubData.Brooklyn.currentConditionsResponse
    }
    
    func getForecast(latitude: Double, longitude: Double) async -> ForecastResponse? {
        return StubData.Brooklyn.forecastResponse
    }
}
