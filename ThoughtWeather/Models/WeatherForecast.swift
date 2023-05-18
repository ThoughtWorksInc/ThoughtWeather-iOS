import Foundation

// WeatherForecast is a domain object for the weather forecast.
// The initializer translates from a ForecastResponse DTO into this domain object.
struct WeatherForecast {
    let cityName: String
    let allItems: [HourlyItem]
    let days: [Day]
    
    init(forecastResponse: ForecastResponse) {
        self.cityName = forecastResponse.city.name
        self.allItems = forecastResponse.timeForecasts.map { HourlyItem(pointForecast: $0) }
        self.days = WeatherForecast.buildDays(hourlyItems: self.allItems)
    }

    // This method is called by the initializer, to translate the hourly elements in the
    // response DTO into a collection of WeatherForecast.Day summary models.
    private static func buildDays(hourlyItems: [HourlyItem]) -> [Day] {
        var daysDict = [Date : [HourlyItem]]()
        
        // The collection of hourlyItems comes at three-hour intervals for five days.
        // Here, split the hourlyItems arrays into one for each calendar day (within a dictionary).
        hourlyItems.forEach { hourlyItem in
            let day = hourlyItem.date.day
            if daysDict[day] == nil {
                daysDict[day] = [hourlyItem]
            } else {
                daysDict[day]?.append(hourlyItem)
            }
        }
        // daysDict now has lists of hourlyItems, one for each date.
        // We'll aggregate these into Day structs that are held by the WeatherForecast.
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
        
        init(pointForecast: ForecastResponse.TimeForecast) {
            self.date = Date(timeIntervalSince1970: Double(pointForecast.dt))
            self.temperature = Temperature(kelvin: pointForecast.temperatures.temp)
            self.lowTemperature = Temperature(kelvin: pointForecast.temperatures.tempMin)
            self.highTemperature = Temperature(kelvin: pointForecast.temperatures.tempMax)
        }
    }
}

// Date.day is a convenience extension to get a Date object without hour/minute/second,
// in the device's current time zone.  I.e. U.S. EDT is UTC-0400, so:
// '2023-05-17T14:55:00-0400'.day == '2023-05-17T00:00:00-0400' == '2023-05-17T04:00:00Z'
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
