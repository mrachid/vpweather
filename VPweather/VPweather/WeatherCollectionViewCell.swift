//
//  WeatherCollectionViewCell.swift
//  VPweather
//
//  Created by Rachid on 07/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var weatherInfo : Weather?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        if let obj = weatherInfo{
            tempLabel.text = String(obj.temperatur)
            iconImageView.image = UIImage(named: obj.icon)
            
            let date = obj.time.components(separatedBy: ":")
            timeLabel.text = date.first! + "h"
        }
        
    }
}
