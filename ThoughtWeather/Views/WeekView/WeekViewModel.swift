import Foundation
import Combine
import CoreLocation

class WeekViewModel {
    fileprivate var locationService: LocationServiceType = SimpleLocationService()
    fileprivate var dataClient: WeatherClientType = WeatherClient()
    
    fileprivate var forecast: WeatherForecast?
    fileprivate var currentLocation: CLLocationCoordinate2D? = nil
    
    @Published var title: String = ""
    @Published var data: [WeatherForecast.Day] = []
    @Published var isLoading: Bool = false
    
    init() {}
    
    func reloadData() {
        isLoading = true
        Task { [weak self] in
            guard let location = await self?.locationService.getLocation() else {
                self?.title = "Could not retrieve device location"
                return
            }
            self?.currentLocation = location.coordinate
            
            guard let latitude = self?.currentLocation?.latitude, let longitude = self?.currentLocation?.longitude else {
                return
            }
            
            let response = try? await self?.dataClient.getForecast(latitude: latitude, longitude: longitude)
            
            guard let response = response else {
                self?.title = "Error fetching forecast"
                return
            }
            
            self?.forecast = response
            self?.title = response.cityName
            self?.data = response.days
            self?.isLoading = false
        }
    }
}
