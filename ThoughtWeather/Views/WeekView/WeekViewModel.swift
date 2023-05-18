//
//  WeekViewModel.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-17.
//

import Foundation

class WeekViewModel {
    let weatherForecast: WeatherForecast

    var forecastDays: [WeatherForecast.Day] {
        self.weatherForecast.days.sorted {
            $0.date < $1.date
        }
    }
    
    init(weatherForecast: WeatherForecast) {
        self.weatherForecast = weatherForecast
    }
}
