//
//  ViewController.swift
//  VPweather
//
//  Created by Rachid on 07/11/2016.
//  Copyright © 2016 Rachid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var apiWeather = APIWeather()
    
    private struct StoryBoard {
        static let WeatherTableViewCellIdentifier = "weatherCell"
        static let WeatherDetailSegue = "weatherDetail"
    }
    
    private func alertErrorDataWeather(){
        let alertController = UIAlertController(title: "Une erreur est survenue", message: "Veuillez vérifier votre connexion internet", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        apiWeather.getWeather { (info) in
            if info == "SUCCESS"{
                let obj = self.apiWeather.listWeathers.first?.sectionObjects.first
                if let temp = obj?.temperatur{
                    self.temperatureLabel.text = String(temp)
                }
                self.infoLabel.text = obj?.description
                self.tableView.reloadData()
            }
            else{
                self.alertErrorDataWeather()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiWeather.listWeathers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoard.WeatherTableViewCellIdentifier, for: indexPath) as? WeatherTableViewCell
        
        cell?.weatherInfo = apiWeather.listWeathers[indexPath.row].sectionObjects.first
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.WeatherDetailSegue{
            var destinationvc = segue.destination
            if let navcon = destinationvc as? UINavigationController{
                destinationvc = navcon.visibleViewController ?? destinationvc
            }
        
            if let wdvc = destinationvc as? WeatherDetailsViewController {
                let obj = apiWeather.listWeathers[(tableView.indexPathForSelectedRow?.row)!].sectionObjects
                wdvc.title = apiWeather.dateFormatDisplay(data: (obj?.first)!)
                wdvc.weathers = obj
            }
        }
    }

}

