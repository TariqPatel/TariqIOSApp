//
//  Models.swift
//  TariqIOSApp
//
//  Created by Tariq Patel on 2022/01/23.
//

import Foundation

struct WeatherModel: Hashable, Codable {
    let weather: [CurrentWeather]?
    let main: Main?
}

struct WeatherList: Hashable, Codable {
    let list: [WeatherModel]
    let city: City?
}

struct City: Hashable, Codable {
    let name: String?
}

struct CurrentWeather: Hashable, Codable {
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Hashable, Codable {
    let temp: Double?
}

struct Location {
    let latitude: Double?
    let longitude: Double?
}

struct WeatherDetails {
    let title: String
    let description: String
    let temp: String
    let name: String
    let weatherIconUrl: String
}
