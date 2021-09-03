//
//  WeatherDataModel.swift
//  WhatsTheWeather
//
//  Created by jeazous on 7/27/21.
//

import Foundation
import UIKit

class WeatherDataModel {

    //These are properties or models for Weather data
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //This method turns a condition code into the name of the weather condition image
    func getTempColor() -> [Float] {
        let temp = Float(self.temperature)
        let max = Float(256.0)
        let over8 = Float(32.0)
        let over10 = Float(25.6)
        let over20 = Float(12.8)
        var colorBlue: Float = 0.0
        var colorGreen: Float = 0.0
        var colorRed: Float = 0.0
        if (temp < 20.0) {
            colorBlue = ((20.0 - temp) * over20)/max
        }
        if (temp < 30) && (temp >= 22) {
            colorGreen = ((30 - temp) * over8)/max
        }
        if (temp < 22) && (temp >= 14) {
            colorGreen = ((temp - 14) * over8)/max
        }
        if (temp > 26) && (temp <= 36)  {
            colorRed = (256 - ((36 - temp) * over10))/max
        }
        if (temp > 36) && (temp <= 46) {
            colorRed = (256 - (temp - 36))/max
        }
        if (temp > 46) {
            colorRed = 0.5
        }
        
        return [colorRed,  colorGreen,  colorBlue]
    }
    
    //This method turns a condition code into the name of the weather condition image
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"
        
        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        case 900...903, 905...1000  :
            return "tstorm3"
        
        case 903 :
            return "snow5"
        
        case 904 :
            return "sunny"
        
        default :
            return "dunno"
        }

    }
}
