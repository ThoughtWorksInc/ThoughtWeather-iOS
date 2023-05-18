//
//  Brooklyn.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation
import CoreLocation

extension StubData {
    struct Brooklyn {
        static let location = (latitude: 40.671459, longitude: -73.952001)

        static let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)

        static let forecastResponse: ForecastResponse? = loadJson(fileName: "BrooklynForecast")
    }
}
