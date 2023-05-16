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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldInstantiateFromForecastResponse() {
        let weatherForecast = WeatherForecast(forecastResponse: StubData.Brooklyn.forecastResponse!)
        
        
    }
}
