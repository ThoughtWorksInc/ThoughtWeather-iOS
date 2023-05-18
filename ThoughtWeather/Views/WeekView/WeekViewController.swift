//
//  WeekViewController.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-10.
//

import UIKit
import CoreLocation

class WeekViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var locationService: LocationServiceType = LocationService()
    var data: WeatherClientType = WeatherClient()
    
    var forecast: WeatherForecast? {
        didSet {
            guard let cityName = forecast?.cityName else { return }
            self.title = "Weather for \(cityName)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Weather"
        
        tableView.dataSource = self
        
        Task { [weak self] in
            guard let location = await self?.locationService.getLocation() else {
                fatalError("Could not retrieve device location")
            }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let response = try! await self?.data.getForecast(latitude: latitude, longitude: longitude)!

            print(response)
            if let responseValid = response {
                self?.forecast = responseValid
                self?.tableView.reloadData()
            }
        }
    }
}

extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecast?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmp = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastDayCell
        
        guard let cell = tmp else { fatalError("ForecastDayCell is not properly registered.")}
        let weatherInfo = forecast!.days[indexPath.row]
        cell.setup(data: weatherInfo)
        return cell
    }
}

