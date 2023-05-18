import Foundation
import CoreLocation

protocol LocationServiceType {
    func getLocation() async -> CLLocation?
}
