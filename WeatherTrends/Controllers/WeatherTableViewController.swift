//
//  WeatherTableViewController.swift
//  WeatherTrends
//
//  Created by Andrew on 5/30/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    var weatherSource = WeatherSource()
    var customCellView = CustomTableViewCell()
    

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherSource.fetchData()
        weatherSource.tableController = self
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherSource.parsedTextData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId(), for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let weather = weatherSource.parsedTextData[indexPath.row]
        cell.customViewCell.layer.cornerRadius = 12 // custom cell corner radius
        cell.configure(yyyy: weather[0], mm: weather[1], tmax: weather[2], tmin: weather[3], af: weather[4], rain: weather[5], sun: weather[6])
        
        return cell
    }

}
