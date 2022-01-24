//
//  WeatherService.swift
//  TariqIOSApp
//
//  Created by Tariq Patel on 2022/01/23.
//

import Foundation

class WeatherService {
    
    //Fetching data from open weather map
//    func fetchWeather(latitude: String, longitude: String, completion: @escaping (_ weather: WeatherDetails?) -> Void) {
//        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=be68c57ac21a2f47f9a12bd99387a085") else {
//            completion(nil)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) {data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            do {
//                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
//                let weatherDetail = self.setWeatherObject(weather)
//                completion(weatherDetail)
//
//            } catch {
//                print(error)
//            }
//        }
//
//        task.resume()
//    }
    
    //fetching data using rapidAPI
    func fetchRapidApiWeather(latitude: String, longitude: String, completion: @escaping (_ weather: [WeatherForcast]) -> Void) {
        let headers = [
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
            "x-rapidapi-key": "4cc62ba75bmsh6b5551f1b0b049fp1b9415jsn588f479d742b"
        ]
   
        // I noticed if I leave out a city, the endpoint is not able to bring back a city for me to output
        let request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/forecast?q=cape%20town&\(latitude)&lon=\(longitude)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherList.self, from: data)
                let weatherDetail = self.setWeatherForcast(weather, weather.city?.name ?? "")
                completion(weatherDetail)
                
            } catch {
                print(error)
            }
            
        })
//
        dataTask.resume()
    }
    
//    func setWeatherObject(_ weatherObjectList: WeatherList, _ cityName: String) -> [WeatherDetails] {
//        var weatherDetailList: [WeatherDetails] = []
//        for weatherObject in weatherObjectList.list{
//
//        }
//
//        return weatherDetailList
//    }
    
    func setWeatherForcast(_ weatherObjectList: WeatherList , _ cityName: String) -> [WeatherForcast] {
        var weatherForcast: [WeatherForcast] = []
        var dayCounter = 0
        var weatherDetailList: [WeatherForcast] = []
        for weatherObject in weatherObjectList.list{
            let date = weatherObject.dt_txt
            let imageUrl = "https://openweathermap.org/img/w/"
            let title = weatherObject.weather?.first?.main ?? "empty"
            let description = weatherObject.weather?.first?.description ?? "empty"
            let temp = String(weatherObject.main?.temp ?? 0) + "°"
            let name = String(cityName)
            let weatherIcon = weatherObject.weather?.first?.icon ?? "empty"
            let weatherIconUrl = imageUrl + weatherIcon + ".png"
            let weatherDetails = WeatherForcast(title: title,
                                               description: description,
                                               temp: temp,
                                               name: name,
                                               weatherIconUrl: weatherIconUrl,
                                               header: false,
                                               weatherDetails: [],
                                               date: date)
            weatherDetailList.append(weatherDetails)
            dayCounter += 1
            if dayCounter == 8 {
                let weatherF = WeatherForcast(title: title,
                                              description: description,
                                              temp: temp,
                                              name: name,
                                              weatherIconUrl: weatherIconUrl,
                                              header: true,
                                              weatherDetails: weatherDetailList,
                                              date: date)
                weatherForcast.append(weatherF)
                weatherDetailList = []
                dayCounter = 0
            }
        }
        
        return weatherForcast
    }
}
