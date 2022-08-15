//
//  ViewController.swift
//  What Weather
//
//  Created by Burak Altunoluk on 13/08/2022.
//

import UIKit
import AlertToast

final class MainVC: UIViewController {
    //MARK: Properties
    @IBOutlet private var locationTextFiled: UITextField!
    @IBAction private func searchButton(_ sender: UIButton) {
//        if locationTextFiled.text != "" {
//            performSegue(withIdentifier: "toDetails", sender: nil)
//        }
        alertShow()
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
            vc.location = locationTextFiled.text!
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func alertShow()  {
        
        let storyboard = UIStoryboard(name: "Alerts", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertViewControler") as! AlertVC
        present(alertVC, animated: true)
        
    }
    
    
}



