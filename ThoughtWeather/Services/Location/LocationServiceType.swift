//
//  LocationServiceType.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation
import CoreLocation

protocol LocationServiceType {
    func getLocation() async -> CLLocation?
}
