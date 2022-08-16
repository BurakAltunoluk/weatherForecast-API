//
//  AlertVC.swift
//  What Weather
//
//  Created by Burak Altunoluk on 15/08/2022.
//

import UIKit

class AlertVC: UIViewController {
    @IBOutlet var alertDetails: UILabel!
    var message = ""
    
    @IBAction func okButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertDetails.text = message

    
    }
    


}
