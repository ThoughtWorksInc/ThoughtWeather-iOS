//
//  StubLocationService.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation
import CoreLocation

class StubLocationService: LocationServiceType {
    func getLocation() async -> CLLocation? {
        // Beautiful Crown Heights, Brooklyn
        return StubData.Brooklyn.clLocation
    }
}
