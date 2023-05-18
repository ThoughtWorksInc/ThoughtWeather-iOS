import Foundation
import CoreLocation

// LocationService is a simple wrapper that converts CLLocationManager's delegate events
// into a more modern async/await pattern.  It does the job but needs hardening before use
// in a production app.
class SimpleLocationService: NSObject, LocationServiceType {
    private let locationManager: CLLocationManager
    
    private var locationAuthorizationHandler: ((CLLocationManager) -> Void)?
    private var locationHandler: ((CLLocation?, Error?) -> Void)?
    
    override init() {
        self.locationManager = CLLocationManager()
        
        super.init()
        
        self.locationManager.delegate = self
    }
    
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
    
    fileprivate func requestLocationPermission() async -> Bool {
        let initialStatus = self.locationManager.authorizationStatus
        
        // Don't request authorization again, if status is already known.
        // To do so will cause a hang
        guard initialStatus == .notDetermined else {
            return [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse].contains(initialStatus)
        }
        
        return await withCheckedContinuation { continuation in
            self.locationAuthorizationHandler = { locationManager in
                self.locationAuthorizationHandler = nil
                let authorizationStatus = locationManager.authorizationStatus
                switch authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse:
                    continuation.resume(returning: true)
                default:
                    print("Location not authorized.  Status: \(authorizationStatus)")
                    continuation.resume(returning: false)
                }
            }
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    fileprivate func requestLocation() async throws -> CLLocation {
        let location: CLLocation = try await withCheckedThrowingContinuation { continuation in
            self.locationHandler = { location, error in
                self.locationHandler = nil
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let location = location {
                    continuation.resume(returning: location)
                } else {
                    continuation.resume(throwing: LocationError.unableToRetrieve)
                }
            }
            locationManager.requestLocation()
        }
        return location
    }
}

extension SimpleLocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationAuthorizationHandler?(manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationHandler?(locations.last, nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationHandler?(nil, error)
    }}

enum LocationError: Error {
    case denied
    case restricted
    case notDetermined
    case unableToRetrieve
}
