//
//  WeatherClientType.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation

protocol WeatherClientType {
    func getCurrentConditions(date: Date, latitude: Double, longitude: Double) async -> CurrentConditionsResponse?
    func getForecast(latitude: Double, longitude: Double) async -> ForecastResponse?
}
