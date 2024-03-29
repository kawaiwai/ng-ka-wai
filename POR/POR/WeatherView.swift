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
            return "☁️" // partly cloudy
        case 62:
            return "🌧️" // little Rain
        case 63:
            return "🌧️" // Rain
        case 65:
            return "⛈️" // thunderstorm
        case 93:
            return "❄️"// cold
        case 80:
            return "💨" // Strong wind
        default:
        print("\(icon)")
            return "❓"
        }
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
                                        Text("Date: \(forecast.forecastDate) (\(forecast.week))")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundStyle(.brown)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Temperature: \(forecast.forecastMintemp.value)°\(forecast.forecastMintemp.unit) - \(forecast.forecastMaxtemp.value)°\(forecast.forecastMaxtemp.unit) ")
                                            .font(.system(size: 15))
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Relative Humidity: \(forecast.forecastMinrh.value)% - \(forecast.forecastMaxrh.value)%").font(.system(size: 15))
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
                .navigationTitle("Future Weather Report")
            } else {
                Text("No weather data")
                    .navigationTitle("Future Weather Report")
            }
            
        }
    }
}

struct WeatherView_Preview : PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
