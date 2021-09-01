
# App Challenge Week 12 - What's The Weather Today?
**Deadline: Friday**

This is a step-by-step challenge that guides you through the entire process of the App Challenge.

**Important: Aside from the previous App Challenges, you will also be using what you've learned from hands-on activities**

# What You Will Be Making - An app that displays the real-time weather data of a city
<img width="1381" alt="weather data" src="https://user-images.githubusercontent.com/87120195/131660031-e743b9cc-3520-4eec-a9a0-3b264439c58a.png">



# What You Will Be Learning

1. Networking - https://www.youtube.com/watch?v=Rqr3w8scm2E
2. JSON - https://www.youtube.com/watch?v=_TrPJQWD8qs
3. APIS - https://www.youtube.com/watch?v=s7wmiS2mSXY


# Important keywords
1. Networking
2. JSON
3. APIs
4. Alamofire
5. SwiftyJSON
6. Http request
7. Introduction Core Location


# Coding advice

1. If you can, use a piece of paper to sketch your pseudocode (human-readable language)
2. Start writing code (start small and divide and conquer)
3. Start on simple tasks like UI-related code
4. THen, proceed with the logic of the app
5. Be mindful on doing one particular task at a time
6. Use Stackoverflow or complementary resources when stuck or in case of an error


# Steps

**Part 1**

Step 1: Download the Starter project

Step 2: Quit your Xcode project, go to Terminal, navigate to your project directory/folder, and initialize pod using _pod init_ command in the terminal

<img width="893" alt="Screen Shot 2021-08-24 at 7 00 06 PM" src="https://user-images.githubusercontent.com/87120195/130605325-83d7d864-f40d-430f-b0fa-5b191bc7af38.png">


Step 3: Open the Pod file and put these two pods respectively in the file, _Alamofire and SwiftyJSON_. 

<img width="283" alt="Screen Shot 2021-08-24 at 6 44 09 PM" src="https://user-images.githubusercontent.com/87120195/130603399-042482bb-14ce-4ad7-acbc-f25bef97c767.png">
Note: Make sure you uncomment the _use_frameworks and target platform :ios, '9.0'_

Step 4: Go back to terminal again and now do _pod install_. Wait until it's done. Then open your project using .xcworkspace

**Part 2**

Step 5: Import both libraries Alamofire and SwiftyJSON on the top of your MainWeatherController file. 
<img width="361" alt="Screen Shot 2021-08-24 at 6 45 49 PM" src="https://user-images.githubusercontent.com/87120195/130603726-e55837a9-f081-4bf7-ba94-7d9bc7880731.png">

Step 6: In this project, you'll see a constant called APP_KEY. This will contain your API key.
Make sure you verify your account through your email!

So all you need to do is set up your own free account on OpenWeatherMap and get a free appid. You can get one here:

http://openweathermap.org/appid

Afterwards you'll need to replace the appid variable named "APP_KEY" with your own app id for your app to work. When you create your account on OpenWeatherMap, you'll see this key on your API keys. Copy paste into your constant "APP_KEY" on Xcode.

<img width="1440" alt="Screen Shot 2021-09-01 at 5 59 57 PM" src="https://user-images.githubusercontent.com/87120195/131658225-9291ea23-04fe-489a-bb71-3bfb7e916a1c.png">


**Part 3**

Step 7: Networking - Insert this block of code inside your MainWeatherController file
Networking is when you communicate to other computers in the world wide web. In a simple sense, networking in Swift involves writing a block of code that fetches data from other web platform or services so you can utilize their existing datasets.


    func getWeatherData(url: String, parameters: [String: String]) {
        

        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }

Step 8: JSON Parsing - And this one too just under the block of code from Networking
JSON parsing is the art of converting JSON string into usable types or objects. 

     func updateWeatherData(json : JSON) {
    
        let tempResult = json["main"]["temp"].doubleValue
    
            weatherDataModel.temperature = Int(tempResult - 273.15)
    
            weatherDataModel.city = json["name"].stringValue
    
            weatherDataModel.condition = json["weather"][0]["id"].intValue
    
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
    
    
            updateUIWithWeatherData()
        }
        
      
    
Step 9: UI Updates - Insert this block of code


  func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }

Step 10: Change City delegate - Insert the inside the function body of userEnteredANewCityName under Change City Delegates Method

 
        let params : [String : String] = ["q" : city, "appid" : APP_KEY]
        
        getWeatherData(url: WEATHER_URL, parameters: params)



Step 11: Call or invoke getWeatherData(url: WEATHER_URL, parameters: params) on the first locationManager delegate method under "let params"


Final step: Run the app and make sure it displays real-time data of a sample weather data of San Francisco and test it by changing the location of the city



Copyright 2021 Hikre, Inc. Hikre School
