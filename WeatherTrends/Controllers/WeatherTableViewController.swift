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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var weatherSource = WeatherSource()
    var data = [WeatherData]()
    var filteredData = [WeatherData]()

    // MARK: - IBOutlets
    
    @IBOutlet var tableview: UITableView!
    
    // MARK: - UITableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarController()
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
        return data.isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredData.count
        }
        return self.data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseId(), for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let weather: WeatherData
        weather = searchController.isActive ? filteredData[indexPath.row] : data[indexPath.row]
        cell.configure(yyyy: weather.year, mm: weather.mm, tmax: weather.tmax, tmin: weather.tmin, af: weather.af, rain: weather.rain, sun: weather.sun)
        
        return cell
    }
}

// MARK: - SearchBar

extension WeatherTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredData = data
        } else {
            // Filter the results
            filteredData = data.filter {
                $0.year.lowercased().contains(searchController.searchBar.text!.lowercased())
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - SearchBar settings
    
    func searchBarController() {
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.2304475904, green: 0.3820989728, blue: 0.482727468, alpha: 1)
        searchController.searchBar.placeholder = "Search by year..."
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
}
