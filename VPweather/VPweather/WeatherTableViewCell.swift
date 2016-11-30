//
//  WeatherTableViewCell.swift
//  VPweather
//
//  Created by Rachid on 07/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    private let apiWeather = APIWeather()
    
    var weatherInfo: Weather?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        
        if let info = weatherInfo {
            dateLabel.text = apiWeather.dateFormatDisplay(data: info)
            infoLabel.text = info.description
            temperatureLabel.text = String(info.temperatur)
        }
        
    }
    
}
