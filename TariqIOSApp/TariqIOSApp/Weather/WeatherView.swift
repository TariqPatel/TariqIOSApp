//
//  ContentView.swift
//  TariqIOSApp
//
//  Created by Tariq Patel on 2022/01/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var locationManager = LocationManager()
    @State private var showWeather = false
        var userLatitude: String {
            return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
        }
        
        var userLongitude: String {
            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
        }
    
    var body: some View {
        NavigationView {
            VStack {
            if showWeather {
                List(viewModel.weatherForcast, children: \.weatherDetails) { forcast in
                    WeatherDetailView(weatherDetail: forcast).listRowSeparator(.hidden)
                }
            } else {
                Text("I wonder what the weather is for the next 5 days?").padding()
                    .padding(20).font(.system(size: 30)).multilineTextAlignment(.center)
            }
                Button("Check Weather", action: getWeather).font(.system(size: 18))
                    .padding(20)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    
            }.background(Color.white)
        }
        .navigationTitle("Weather").background(Color.white).listRowSeparator(.hidden)
    }
    
    //Get the weather data from the view model
    func getWeather() {
        viewModel.getWeatherFromService(latitude: userLatitude, longitude: userLongitude)
        showWeather = true
    }
}

struct WeatherDetailView: View {
    var counter = 1
    var weatherDetail: WeatherForcast
    var body: some View {
        let index = weatherDetail.date.index(weatherDetail.date.startIndex, offsetBy: 10)
        let dateFormatted = weatherDetail.date[..<index]
        if weatherDetail.header {
            VStack {
                Text(weatherDetail.name)
                    .bold().font(.system(size: 18))
                Text(dateFormatted)
                    .bold().font(.system(size: 12))
            }
        } else {
            AsyncImage(url: URL(string: weatherDetail.weatherIconUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.clear
                        }
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        Text(weatherDetail.temp)
                            .bold().font(.system(size: 18))
                        VStack {
                            Text(weatherDetail.title)
                                .bold().font(.system(size: 14))
                            Text(weatherDetail.description).font(.system(size: 14)).listRowSeparator(.hidden)
                        }
                    
                }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
