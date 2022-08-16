//
//  DetailsVC.swift
//  What Weather
//
//  Created by Burak Altunoluk on 13/08/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlertToast

final class DetailsVC: UIViewController {
    
    //MARK: Properties
    var location = ""
    var todayWeatherDetails = [WeatherForecast]()
    @IBOutlet private var weatherStatuImage: UIImageView!
    @IBOutlet private var maxLabel: UILabel!
    @IBOutlet private var minLabel: UILabel!
    @IBOutlet private var degreeLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    //MARK: Button
    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.degreeLabel.text = "\(String(self.todayWeatherDetails[0].temp))º"
        self.locationLabel.text = String(self.todayWeatherDetails[0].name)
        self.maxLabel.text = "max: \(String(self.todayWeatherDetails[0].temp_max))º"
        self.minLabel.text = "min: \(String(self.todayWeatherDetails[0].temp_min))º"
        self.weatherStatuImage.image = UIImage(named: self.todayWeatherDetails[0].weather)
    }
}
