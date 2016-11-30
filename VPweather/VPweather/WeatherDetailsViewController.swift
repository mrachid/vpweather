//
//  WeatherDetailsViewController.swift
//  VPweather
//
//  Created by Rachid on 07/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var weathers : [Weather]?
    private struct StoryBoard {
        static let WeatherCollectionCellIdentifier = "weatherCollectionCell"
    }

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var describLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var seaLabel: UILabel!
    @IBOutlet weak var groundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.clear
        updateUI()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (weathers?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.WeatherCollectionCellIdentifier, for: indexPath) as? WeatherCollectionViewCell
        
        cell?.weatherInfo = weathers?[indexPath.row]
        
        return cell!
    }
    
    func updateUI() {
        if let weather = weathers?.first{
            tempLabel.text = String(weather.temperatur)
            describLabel.text = weather.description
            maxLabel.text = String(weather.tempMax) + " °C"
            humidityLabel.text = String(weather.humidity) + " %"
            windLabel.text = String(weather.wind) + " m/s"
            cloudsLabel.text = String(weather.clouds) + " %"
            seaLabel.text = String(weather.sealvl) + " hPa"
            groundLabel.text = String(weather.grndlvl) + " hPa"
        }
        
    }
    
    @IBAction func closeModal(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
