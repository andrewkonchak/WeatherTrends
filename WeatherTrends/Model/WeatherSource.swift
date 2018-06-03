//
//  WeatherSource.swift
//  WeatherTrends
//
//  Created by Andrew on 6/3/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import Foundation

class WeatherSource {
    
    var parsedTextData = [[String]]()
    var tableController: WeatherTableViewController?
    
    // MARK: - Fetch elements from .txt file
    func fetchData() {
        DispatchQueue.global(qos: .userInteractive).async {
            let session = URLSession(configuration: .ephemeral)
            let url = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/bradforddata.txt")!
            let task = session.dataTask(with: url) { (data, response, error) -> Void in
                guard let data = data else { return }
                guard let textData = String(data: data, encoding: String.Encoding.utf8) else { return }
                do {
                    self.parsedTextData = try Parser.parse(textData: textData)
                    DispatchQueue.main.async {
                        self.tableController?.tableview.reloadData()
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
