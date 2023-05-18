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

    func setup(data: WeatherForecast.Day) {
        leftLabel.text = data.date.toString()
        centerLabel.text = "Lo: \(Int(data.lowTemperature?.celsius ?? 0))"
        rightLabel.text = "Hi: \(Int(data.highTemperature?.celsius ?? 0))"
    }
}

fileprivate extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
