//
//  StubDataTests.swift
//  ThoughtWeatherTests
//
//  Created by Michael Chaffee on 2023-05-16.
//

import XCTest
@testable import ThoughtWeather

final class StubDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldLoadGoodCurrentConditions() throws {
        let currentConditionsResponse = StubData.Brooklyn.currentConditionsResponse
        XCTAssertEqual("stations", currentConditionsResponse?.base)
        XCTAssertEqual("Clear", currentConditionsResponse?.weather.first?.main)
    }

    func testShouldLoadGoodForecast() throws {
        let forecastResponse = StubData.Brooklyn.forecastResponse
        XCTAssertEqual(297.95, forecastResponse?.timeForecasts.first?.temperatures.temp)
    }

}
