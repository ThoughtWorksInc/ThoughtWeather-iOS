//
//  WeatherForecast.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-16.
//

import Foundation

struct WeatherForecast {
    let allItems: [HourlyItem]
    let days: [Day]
    
    init(forecastResponse: ForecastResponse) {
        self.allItems = forecastResponse.list.map { HourlyItem(pointForecast: $0) }
        self.days = WeatherForecast.buildDays(hourlyItems: self.allItems)
    }

    private static func buildDays(hourlyItems: [HourlyItem]) -> [Day] {
        var daysDict = [Date : [HourlyItem]]()
        
        hourlyItems.forEach { hourlyItem in
            let day = hourlyItem.date.day
            if daysDict[day] == nil {
                daysDict[day] = [hourlyItem]
            } else {
                daysDict[day]?.append(hourlyItem)
            }
        }
        // daysDict now has a list of hourlyItems for each date.  Need to aggregate this into Day structs
        // TODO need to use hourly temp_min, temp_max from response
        let result = daysDict.map { day, hourlyItems in
            let lowTemperature = hourlyItems.map({ $0.lowTemperature }).min(by: <)
            let highTemperature = hourlyItems.map({ $0.highTemperature }).max(by: <)
            return Day(date: day, highTemperature: highTemperature, lowTemperature: lowTemperature, hourlyItems: hourlyItems)
        }.sorted(by: { lhs, rhs in lhs.date < rhs.date })

        return result
    }
    
    struct Day {
        let date: Date
        let highTemperature: Temperature?
        let lowTemperature: Temperature?
        let hourlyItems: [HourlyItem]
    }
    
    struct HourlyItem {
        let date: Date
        let temperature: Temperature
        let lowTemperature: Temperature
        let highTemperature: Temperature
        
        init(pointForecast: ForecastResponse.PointForecast) {
            self.date = Date(timeIntervalSince1970: Double(pointForecast.dt))
            self.temperature = Temperature(kelvin: pointForecast.main.temp)
            self.lowTemperature = Temperature(kelvin: pointForecast.main.tempMin)
            self.highTemperature = Temperature(kelvin: pointForecast.main.tempMax)
        }
    }
}

fileprivate typealias DayComponents = (year: Int, month: Int, day: Int)
fileprivate extension Date {
    var day: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        guard let day = calendar.date(from: dateComponents) else {
            fatalError("BAD DATE")
        }
        return day
    }
}
