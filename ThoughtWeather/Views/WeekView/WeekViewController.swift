//
//  WeekViewController.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-10.
//

import UIKit

class WeekViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var data: WeatherClientType = StubWeatherClient()
    
    var items: [ForecastResponse.PointForecast] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Weather"
        
        tableView.dataSource = self
        
        Task { [weak self] in
            let response = await self?.data.getForecast(latitude: 1.0, longitude: 1.0)?.list.filter({ item in
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
