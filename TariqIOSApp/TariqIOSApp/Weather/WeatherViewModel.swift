//
//  ViewModel.swift
//  TariqIOSApp
//
//  Created by Tariq Patel on 2022/01/23.
//

import Foundation
import CoreLocation

class ViewModel: ObservableObject {
    @Published var weatherForcast: [WeatherForcast] = []
    
    //Get the weather data from the weather service
    func getWeatherFromService(latitude: String, longitude: String) {
        WeatherService().fetchRapidApiWeather(latitude: latitude, longitude: longitude, completion: { (weatherDetails) -> Void in
            DispatchQueue.main.async {
                self.weatherForcast = weatherDetails
            }
        })
    }
}

//self.title = weatherDetail?.title ?? "-"
//self.description = weatherDetail?.description ?? "-"
//self.temp = weatherDetail?.temp ?? "-"
//self.name = weatherDetail?.name ?? "-"
//self.weatherIcon = weatherDetail?.weatherIconUrl ?? "-"
