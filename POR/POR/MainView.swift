//
//  MainView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

struct MainView: View {
    var parkData = ParkData()
    var weatherViewModel = WeatherViewModel()
    @State var parks :  [Park] = []
    @State var weatherData : WeatherData?
    var body: some View {
        TabView {
            ParksView(parks: $parks)
                .tabItem { Label("Parks", systemImage: "figure.walk") }
            WeatherView(weatherData: weatherData)
                .tabItem { Label("Weather", systemImage: "sun.max.fill") }
            NearestView(parks: $parks)
                .tabItem { Label("Nearby", systemImage: "location.fill") }
            RecordsView()
                .tabItem { Label("Records", systemImage: "folder.fill") }
            MyView()
                .tabItem { Label("Account", systemImage: "person.circle.fill") }
            
        }
        .onAppear() {
            parkData.fetch({
                parks in
                print("draw park informations")
                self.parks = parks
            })
            
            weatherViewModel.fetchWeatherData(completion: {
                weather in
                self.weatherData = weather
            })
        }
    }
}

struct MainView_Preview : PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

