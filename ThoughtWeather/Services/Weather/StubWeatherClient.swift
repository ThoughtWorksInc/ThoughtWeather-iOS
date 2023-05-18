//
//  StubWeatherClient.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation

class StubWeatherClient: WeatherClientType {
    func getForecast(latitude: Double, longitude: Double) async -> ForecastResponse? {
        return StubData.Brooklyn.forecastResponse
    }
}
