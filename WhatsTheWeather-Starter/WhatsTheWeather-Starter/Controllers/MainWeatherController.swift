//
//  MainWeatherController.swift
//  WhatsTheWeather
//
//  Created by jeazous on 7/27/21.
//


import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class MainWeatherController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
    
    //API constants, one for API URL and one for API key
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_KEY = "0ee39d6f717d4b5576e95c58f21857bd"
  
    
    // Instance variables here for Core Location and Weather Data Model
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
 
    
    // IBOutlets are already linked up for you
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var loadingLabel: UILabel!
    
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
    func getWeatherData(_ url: String, parameters: [String : String]) {
        cityLabel.text = "Loading ..."
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            angSagotAy in
            if angSagotAy.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(angSagotAy.result.value ?? [])
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            } else {
                print("Error \(String(describing: angSagotAy.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/

    
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON) {
        self.weatherDataModel.temperature = Int(json["main"]["temp"].doubleValue - 273.15)
        self.weatherDataModel.city = json["name"].stringValue
        self.weatherDataModel.condition = json["weather"][0]["id"].intValue
        self.weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        updateUIWithWeatherData()
    }
  
            
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        self.temperatureLabel.text = "\(weatherDataModel.temperature)º"
        self.weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        self.cityLabel.text = weatherDataModel.city
    }
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/

    //Write the didUpdateLocations method here:
    func didUpdateLocation() {
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_KEY]
            
            getWeatherData(self.WEATHER_URL, parameters: params)
           
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
        let params : [String : String] = ["q" : city, "appid" : self.APP_KEY]
        self.getWeatherData(self.WEATHER_URL, parameters: params)

    }
    


    
    //Write the PrepareForSegue Method here
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
            
        }
        
    }
    
    
}











