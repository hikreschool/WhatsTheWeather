//
//  MainWeatherController.swift
//  WhatsTheWeather
//
//  Created by jeazous on 7/27/21.
//


import UIKit
import CoreLocation

class MainWeatherController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
    
    //API constants, one for API URL and one for API key
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_KEY = "replace this with your API key"
  
    
    // Instance variables here for Core Location and Weather Data Model
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
 

    
    // IBOutlets are already linked up for you
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        // Core Location Manager configuration
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    


       
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    

    
    
    //MARK: - JSON Parsing
    /***************************************************************/

    
    //Write the updateWeatherData method here:
    
  
            
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/

    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_KEY]
            
           
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    

 
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userEnteredANewCityName(city: String) {
        
    }
    


    
    //Write the PrepareForSegue Method here
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
           
            
        }
        
    }
    
    
}











