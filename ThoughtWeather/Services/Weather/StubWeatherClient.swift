//
//  StubWeatherClient.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation

class StubWeatherClient: WeatherClientType {
    func getWeather(date: Date, latitude: Double, longitude: Double) async -> WeatherResponse {
        return StubData.Brooklyn.weatherResponse
    }
}
