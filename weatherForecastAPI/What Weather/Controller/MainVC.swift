//
//  ViewController.swift
//  What Weather
//
//  Created by Burak Altunoluk on 13/08/2022.
//

import UIKit
import SwiftyJSON
import Alamofire

final class MainVC: UIViewController {
    
    //MARK: Properties
    private var todayWeather = [WeatherForecast]()
    @IBOutlet private var locationTextFiled: UITextField!
    @IBAction private func searchButton(_ sender: UIButton) {
        if !locationTextFiled.text!.isEmpty {
            getData(location: locationTextFiled.text!)
        } else {
            alertShow(message: "Enter a location")
        }
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationTextFiled.text = ""
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let vc = segue.destination as! DetailsVC
            vc.todayWeatherDetails = todayWeather
            todayWeather = [WeatherForecast]()
        }
    }
    
    func getData(location: String) {
        
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
                            self.performSegue(withIdentifier: "toDetails", sender: nil)
                        } else {
                            self.locationTextFiled.text = ""
                            self.alertShow(message: "Not found location")
                        }
                    }
                    
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func alertShow(message: String)  {
        let storyboard = UIStoryboard(name: "Alerts", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertViewControler") as! AlertVC
        alertVC.message = message
        present(alertVC, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}



