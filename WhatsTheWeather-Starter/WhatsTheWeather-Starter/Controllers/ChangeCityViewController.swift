//
//  ChangeCityViewController.swift
//  WhatsTheWeather
//
//  Created by jeazous on 9/1/21.
//
//


import UIKit


// This a protocol declaration
protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}


class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!

    @IBOutlet weak var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWeatherButton.layer.cornerRadius = self.getWeatherButton.frame.height/2
        self.changeCityTextField.layer.cornerRadius = 15
        self.changeCityTextField.layer.borderWidth  = 2
        self.changeCityTextField.layer.borderColor = CGColor(red: 0.8, green: 0.3, blue: 0.0, alpha: 1.0)
        
    }
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {

        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)

        self.dismiss(animated: true, completion: nil)
        
    }
    
    

    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

