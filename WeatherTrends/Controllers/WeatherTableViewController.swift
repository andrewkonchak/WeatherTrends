//
//  WeatherTableViewController.swift
//  WeatherTrends
//
//  Created by Andrew on 5/30/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var weatherSource = WeatherSource()
    var data = [WeatherData]()

    // MARK: - IBOutlets
    
    @IBOutlet var tableview: UITableView!
    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherSource.fetchData { data in
            self.data = data
            self.tableview.reloadData()
        }
    }
    
}
    
// MARK: - UITableViewDelegate
    
extension WeatherTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - UITableViewDataSource
    
extension WeatherTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId(), for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let weather = data[indexPath.row]
        cell.configure(yyyy: weather.year, mm: weather.mm, tmax: weather.tmax, tmin: weather.tmin, af: weather.af, rain: weather.rain, sun: weather.sun)
        
        return cell
    }

}
