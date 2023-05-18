//
//  ForeTableViewCell.swift
//  ThoughtWeather
//
//  Created by Michael Chaffee on 2023-05-16.
//

import UIKit

class ForecastDayCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(data: ForecastResponse.TimeForecast) {
        leftLabel.text = data.dtTxt
        centerLabel.text = data.weather.first?.icon
        rightLabel.text = "\(Int(data.temperatures.temp))"
    }
}
