//
//  StubWeatherClient.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation

class StubWeatherClient: WeatherClientType {
    // TODO is date needed?
    func getCurrentConditions(date: Date, latitude: Double, longitude: Double) async -> CurrentConditionsResponse? {
        return StubData.Brooklyn.currentConditionsResponse
    }
    
    func getForecast(latitude: Double, longitude: Double) async -> ForecastResponse? {
        return StubData.Brooklyn.forecastResponse
    }
}
