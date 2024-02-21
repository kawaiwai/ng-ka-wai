//
//  WeatherView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

struct WeatherView: View {
    var weatherData : WeatherData?
    
    // Define the layout for the horizontal grid.
    var gridItemLayout = [GridItem(.flexible())]
    
    // A placeholder function to map forecast icons to emojis
    func emojiForForecastIcon(_ icon: Int) -> String {
        switch icon {
        case 51:
            return "☀️" // Sun
        case 52:
            return "🌤" // Sun behind cloud
        case 54:
            return "🌦️" // Sun behind cloud
        case 60:
            return "☁️" // Rain
        case 62:
            return "🌧️" // Rain
        case 93:
            return "🌧️" // Rain
        default:
            print("\(icon)")
            return "❓"
        }
        //TODO: complete the weather competition
        //reference: https://www.hko.gov.hk/tc/weatherAPI/doc/files/HKO_Open_Data_API_Documentation_tc.pdf
    }
    
    var body: some View {
        NavigationStack {
            if let weatherData = weatherData {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        
                        ForEach(weatherData.weatherForecast) { forecast in
                            HStack {
                                
                                Text(emojiForForecastIcon(forecast.ForecastIcon))
                                    .font(.system(size: 60))
                                
                                VStack {
                                    
                                    HStack {
                                        Text("\(forecast.forecastDate) (\(forecast.week))")
                                            .font(.system(size: 10, weight: .semibold))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Temperature: \(forecast.forecastMintemp.value)°\(forecast.forecastMintemp.unit) - \(forecast.forecastMaxtemp.value)°\(forecast.forecastMaxtemp.unit) ")
                                            .font(.system(size: 10))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Relative Humidity: \(forecast.forecastMinrh.value)% - \(forecast.forecastMaxrh.value)%").font(.system(size: 10))
                                        Spacer()
                                    }
                                }
                                
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                        
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Weather Forecast")
            } else {
                Text("No weather data")
                    .navigationTitle("Weather Forecast")
            }
            
        }
    }
}

struct WeatherView_Preview : PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
