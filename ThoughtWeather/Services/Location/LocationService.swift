//
//  LocationService.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-11.
//

import Foundation
import CoreLocation

enum LocationError: Error {
    case denied
    case restricted
    case notDetermined
    case unableToRetrieve
}

class LocationService {
    private let locationManager = CLLocationManager()
    
    func getLocation() async -> CLLocation? {
        
        print("getLocation() called")
        let isAuthorized: Bool = await requestLocationPermission()
        
        print("isAuthorized: \(isAuthorized)")
        
        guard isAuthorized else {
            return nil
        }
        
        do {
            return try await requestLocation()
        } catch {
            return nil
        }
    }

    private func requestLocationPermission() async -> Bool {
        print("requestLocationPermission() called")
        return await withCheckedContinuation { continuation in
            let authorizationHandler: (CLAuthorizationStatus) -> Void = { authorizationStatus in
                print("authorizationHandler called")
                switch authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse:
                    continuation.resume(returning: true)
                default:
                    print("Location not authorized.  Status: \(authorizationStatus)")
                    continuation.resume(returning: false)
                }
            }
            let locationAuthorizationDelegate = LocationAuthorizationDelegate(handler: authorizationHandler)
            locationManager.delegate = locationAuthorizationDelegate
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func requestLocation() async throws -> CLLocation {
        let location: CLLocation = try await withUnsafeThrowingContinuation { continuation in
            let locationHandler: (CLLocation?, Error?) -> Void = { location, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let location = location {
                    continuation.resume(returning: location)
                } else {
                    continuation.resume(throwing: LocationError.unableToRetrieve)
                }
            }
            let locationDelegate = LocationDelegate(handler: locationHandler)
            locationManager.delegate = locationDelegate
            locationManager.requestLocation()
        }
        return location
    }
    
    private class LocationAuthorizationDelegate: NSObject, CLLocationManagerDelegate {
        let authorizationHandler: (CLAuthorizationStatus) -> Void
        
        init(handler: @escaping (CLAuthorizationStatus) -> Void) {
            self.authorizationHandler = handler
        }
        
        deinit {
            print("LocationAuthorizationDelegate deinitialized")
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            authorizationHandler(manager.authorizationStatus)
        }
    }
    
    private class LocationDelegate: NSObject, CLLocationManagerDelegate {
        let locationHandler: (CLLocation?, Error?) -> Void

        init(handler: @escaping (CLLocation?, Error?) -> Void) {
            self.locationHandler = handler
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            locationHandler(locations.last, nil)
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            locationHandler(nil, error)
        }
    }
}
