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
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: viewModel.weatherIcon)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.clear
                    }
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    Text(viewModel.name)
                        .bold().font(.system(size: 40))
                    Text(viewModel.temp)
                        .bold().font(.system(size: 60))
                    Text(viewModel.title)
                        .bold().font(.system(size: 30))
                    Text(viewModel.description).font(.system(size: 30))
                }
            } else {
                Text("I wonder what the weather is today?")
                    .bold().font(.system(size: 30))
            }
                Button("Check Weather", action: getWeather).font(.system(size: 18))
                    .padding(20)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    
            }
        }
        .navigationTitle("Weather")
    }
    
    //Get the weather data from the view model
    func getWeather() {
        viewModel.getWeatherFromService(latitude: userLatitude, longitude: userLongitude)
        showWeather = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
