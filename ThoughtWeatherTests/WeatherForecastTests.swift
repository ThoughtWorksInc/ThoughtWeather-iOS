//
//  WeatherForecastTests.swift
//  ThoughtWeatherTests
//
//  Created by Michael Chaffee on 2023-05-16.
//

import Foundation
import XCTest

@testable import ThoughtWeather

final class WeatherForecastTests: XCTestCase {
    let weatherForecast = WeatherForecast(forecastResponse: StubData.Brooklyn.forecastResponse!)
    
    func testShouldInstantiateFromForecastResponse() {
        XCTAssertEqual(40, weatherForecast.allItems.count)
    }
    
    func testShouldAggregateDays() {
        XCTAssertEqual(weatherForecast.days.count, 6)

        let firstDay = weatherForecast.days.first!
        XCTAssertEqual(3, firstDay.hourlyItems.count)
        XCTAssertEqual(293.32, firstDay.lowTemperature?.kelvin)
        XCTAssertEqual(297.96, firstDay.highTemperature?.kelvin)
    }

    func testShouldInstantiateHourlyItemFromPointForecast() {
        let unixDate = 1684270800
        let pointForecast = StubData.Brooklyn.forecastResponse!.list.first(where: { $0.dt == unixDate } )!
        let hourlyItem = WeatherForecast.HourlyItem(pointForecast: pointForecast)
        let expectedDate = Date(timeIntervalSince1970: Double(unixDate))

        XCTAssertEqual(expectedDate, hourlyItem.date)
        XCTAssertEqual(297.95, hourlyItem.temperature.kelvin)
        XCTAssertEqual(296.53, hourlyItem.lowTemperature.kelvin)
        XCTAssertEqual(297.96, hourlyItem.highTemperature.kelvin)
    }
    
}
    