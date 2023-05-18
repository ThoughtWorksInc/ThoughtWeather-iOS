import UIKit
import CoreLocation
import Combine

class WeekViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl: UIRefreshControl = UIRefreshControl()

    private let viewModel: WeekViewModel = WeekViewModel()

    // https://developer.apple.com/documentation/combine
    private var titleCancellable: AnyCancellable?
    private var dataCancellable: AnyCancellable?
    private var isLoadingCancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Weather"
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        titleCancellable = viewModel.$title.sink { value in
            DispatchQueue.main.async {
                self.title = value
            }
        }
        
        dataCancellable = viewModel.$data.sink(receiveValue: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        isLoadingCancellable = viewModel.$isLoading.sink(receiveValue: { isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self.showLoader()
                } else {
                    self.forceHideLoader()
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        })
        
        viewModel.reloadData()
    }
    
    @objc private func refreshData() {
        viewModel.reloadData()
    }
}

extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmp = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastDayCell
        
        guard let cell = tmp else { fatalError("ForecastDayCell is not properly registered.")}
        let weatherInfo = viewModel.data[indexPath.row]
        cell.setup(data: weatherInfo)
        return cell
    }
}

extension WeekViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DayViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


