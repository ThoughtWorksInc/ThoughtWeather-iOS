import Foundation
import CoreLocation

enum LocationError: Error {
    case denied
    case restricted
    case notDetermined
    case unableToRetrieve
}

// LocationService is a simple wrapper that converts CLLocationManager's delegate events
// into a more modern async/await pattern.  It does the job but needs hardening before use
// in a production app.
class LocationService: LocationServiceType {
    private let locationManager = CLLocationManager()
    
    private var locationAuthorizationDelegate: LocationAuthorizationDelegate?
    private var locationDelegate: LocationDelegate?
    
    func getLocation() async -> CLLocation? {
        let isAuthorized: Bool = await requestLocationPermission()
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
        // Re-fetching location permission causes a hang
        let initialStatus = locationManager.authorizationStatus
        guard initialStatus == .notDetermined else {
            return [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse].contains(initialStatus)
        }

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
            self.locationAuthorizationDelegate = LocationAuthorizationDelegate(handler: authorizationHandler)
            locationManager.delegate = locationAuthorizationDelegate
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func requestLocation() async throws -> CLLocation {
        let location: CLLocation = try await withCheckedThrowingContinuation { continuation in
            let locationHandler: (CLLocation?, Error?) -> Void = { location, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let location = location {
                    continuation.resume(returning: location)
                } else {
                    continuation.resume(throwing: LocationError.unableToRetrieve)
                }
            }
            self.locationDelegate = LocationDelegate(handler: locationHandler)
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
