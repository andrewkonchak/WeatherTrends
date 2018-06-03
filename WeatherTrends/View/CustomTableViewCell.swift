//
//  CustomTableViewCell.swift
//  WeatherTrends
//
//  Created by Andrew on 6/3/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var yyyy: UILabel!
    @IBOutlet private weak var mm: UILabel!
    @IBOutlet private weak var tmax: UILabel!
    @IBOutlet private weak var tmin: UILabel!
    @IBOutlet private weak var af: UILabel!
    @IBOutlet private weak var rain: UILabel!
    @IBOutlet private weak var sun: UILabel!
    @IBOutlet weak var customViewCell: UIView!
    
    override func prepareForReuse() {
        self.yyyy.text = ""
        self.mm.text = ""
        self.tmax.text = ""
        self.tmin.text = ""
        self.af.text = ""
        self.rain.text = ""
        self.sun.text = ""
    }
    
    func configure(yyyy: String, mm: String, tmax: String, tmin: String, af: String, rain: String, sun: String) {
        self.yyyy.text = yyyy
        self.mm.text = mm
        self.tmax.text = tmax
        self.tmin.text = tmin
        self.af.text = af
        self.rain.text = rain
        self.sun.text = sun
    }    
}

extension CustomTableViewCell {
    
    static func reuseId() -> String {
        return String(describing: self)
    }
    
}
