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
    
    var location = ""
    private var todayWeather = [WeatherForecast]()
    @IBOutlet private var weatherStatuImage: UIImageView!
    @IBOutlet private var maxLabel: UILabel!
    @IBOutlet private var minLabel: UILabel!
    @IBOutlet private var degreeLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    
    @IBAction private func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
}
    
    func getData() {
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=\(location)&units=metric&appid=b85bef64246bbeb93fffa6e1c47d8fc0")
            .responseData { response in
                
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    DispatchQueue.main.async {
                        
                        if json["name"].rawValue as? String != nil {
                            
                            let newDetails = WeatherForecast(
                                name: json["name"].rawValue as! String,
                                temp: Int(json["main"]["temp"].rawValue as! Double), temp_min: Int(json["main"]["temp_min"].rawValue as! Double),
                                temp_max: Int(json["main"]["temp_max"].rawValue as! Double),
                                weather: "\(json["weather"].array![0]["main"])",
                                weatherDescription: "")
                           
                            self.todayWeather.append(newDetails)
                            self.degreeLabel.text = "\(String(self.todayWeather[0].temp))º"
                            self.locationLabel.text = String(self.todayWeather[0].name)
                            self.maxLabel.text = "max: \(String(self.todayWeather[0].temp_max))º"
                            self.minLabel.text = "min: \(String(self.todayWeather[0].temp_min))º"
                            print("budur \(json["weather"].array![0]["main"])")
                            self.weatherStatuImage.image = UIImage(named: self.todayWeather[0].weather)
                        } else {
                            print("Alert")
                        }
                        
                    }
                    
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        
    }
}
