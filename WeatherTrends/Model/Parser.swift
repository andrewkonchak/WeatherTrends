//
//  Parser.swift
//  WeatherTrends
//
//  Created by Andrew on 6/3/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import Foundation

class Parser {
    
    class func parse(data: String) throws -> [WeatherData] {
        
        // one array element == one line
        let splitedData = data.split(separator: "\r\n")
        
        var index = 0
        if let previousIndex = splitedData.index(of: "              degC    degC    days      mm   hours") {
            index  = previousIndex + 1
        }
        
        // Createing arrays data range
        let rawData = splitedData[index..<splitedData.count].map { $0.split(separator: " ") }
        
        // Clearing elements of array deleting "*" element
        var clearData = rawData.map { $0.map { $0.replacingOccurrences(of: "*", with: "") } }
        
        // Clearing elements of array deleting "#" element
        clearData = clearData.map { $0.map { $0.replacingOccurrences(of: "#", with: "") } }
        
        // Clearing elements of array deleting "Provisional" element
        return clearData.flatMap { element in
            var filteredData = element.filter { $0 != "Provisional" }
            return WeatherData(year: filteredData[0], mm: filteredData[1], tmax: filteredData[2], tmin: filteredData[3], af: filteredData[4], rain: filteredData[5], sun: filteredData[6])
        }
    }
}
