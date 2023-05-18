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
    
    var items: [ForecastResponse.TimeForecast] = []
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
            
            let response = try! await self?.data.getForecast(latitude: latitude, longitude: longitude)?.timeForecasts.filter({ item in
                item.dtTxt.contains("00:00:00")
            })
            print(response)
            if let responseValid = response {
                items = responseValid
                self?.tableView.reloadData()
            }
        }
    }
}

extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmp = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastDayCell
        
        guard let cell = tmp else { fatalError("ForecastDayCell is not properly registered.")}
        let weatherInfo = items[indexPath.row]
        cell.setup(data: weatherInfo)
        return cell
    }
}

