//
//  Parser.swift
//  WeatherTrends
//
//  Created by Andrew on 6/3/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import Foundation

class Parser {
    
    init() {}
    
    class func parse(textData: String) throws -> [[String]] {
        
        // MARK: - one array element == one line
        let splitDataText = textData.split(separator: "\r\n")
        
        var firstIndx = 0
        if let index = splitDataText.index(of: "              degC    degC    days      mm   hours") {
            firstIndx  = index + 1
        }
        
        // MARK: - Createing arrays data range
        var rawMonthlyDataArrays = splitDataText[firstIndx..<splitDataText.count].map {
            $0.split(separator: " ")
        }
        
        // MARK: - Clearing elements of array deleting "*" element
        var clearMonthlyDataArrays = rawMonthlyDataArrays.map {
            $0.map {
                $0.replacingOccurrences(of: "*", with: "")
            }
        }
        
        // MARK: - Clearing elements of array deleting "#" element
        clearMonthlyDataArrays = rawMonthlyDataArrays.map {
            $0.map {
                $0.replacingOccurrences(of: "#", with: "")
            }
        }
        
        // MARK: - Clearing elements of array deleting "Provisional" element
        rawMonthlyDataArrays = rawMonthlyDataArrays.flatMap {
            $0.filter {
                $0 != "Provisional"
            }
        }
        
        return clearMonthlyDataArrays
    }
}
