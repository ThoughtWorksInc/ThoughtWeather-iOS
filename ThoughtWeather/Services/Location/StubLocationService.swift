import Foundation
import CoreLocation

class StubLocationService: LocationServiceType {
    func getLocation() async -> CLLocation? {
        // Beautiful Crown Heights, Brooklyn
        return StubData.Brooklyn.clLocation
    }
}
