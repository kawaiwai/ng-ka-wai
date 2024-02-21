import Foundation

// Define your data structures to match the JSON
struct WeatherData: Codable {
    let generalSituation: String
    let weatherForecast: [DailyForecast]
    //let updateTime: String
    //let seaTemp: SeaTemperature
    //let soilTemp: [SoilTemperature]
}

struct DailyForecast: Codable, Identifiable {
    let id = UUID()
    let forecastDate: String
    let week: String
    let forecastWind: String
    let forecastWeather: String
    let forecastMaxtemp: Temperature
    let forecastMintemp: Temperature
    let forecastMaxrh: Humidity
    let forecastMinrh: Humidity
    let ForecastIcon: Int
    let PSR: String
}

struct Temperature: Codable {
    let value: Int
    let unit: String
}

struct Humidity: Codable {
    let value: Int
    let unit: String
}

struct SeaTemperature: Codable {
    let place: String
    let value: Float
    let unit: String
    let recordTime: String
}

struct SoilTemperature: Codable {
    let place: String
    let value: Float
    let unit: String
    let recordTime: String
    let depth: Depth
}

struct Depth: Codable {
    let unit: String
    let value: Float
}

// ViewModel that will parse the JSON and update the view
class WeatherViewModel: ObservableObject {
    
    let weatherDataURL = URL(string: "https://data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=fnd&lang=en")!

    func fetchWeatherData(completion: @escaping ((WeatherData?) -> (Void))) {
        let task = URLSession.shared.dataTask(with: weatherDataURL) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: data)
                    completion(weatherData)
                } catch {
                    print("Error decoding weather data: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            }
            print("completed")
            completion(nil)
        }
        
        task.resume()
    }
}
