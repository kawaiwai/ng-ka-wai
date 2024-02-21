//
//  ParksManager.swift
//  LetsGoPlay
//
//  Created by ituser on 1/5/24.
//

import Foundation

struct ParkData {
    var parks : [Park] = []
    
    // Call the function with the provided URL
    let urlString = "https://www.lcsd.gov.hk/datagovhk/facility/facility-pefac.json"

    func fetch(_ completion :  @escaping (([Park]) -> Void)) {
        fetchParksData(from: urlString, completion: completion)
    }

    // Function to fetch and parse the JSON data
    func fetchParksData(from urlString: String, completion : @escaping (([Park]) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let parks = try decoder.decode([Park].self, from: data)
                // Work with your parsed objects here
                DispatchQueue.main.async {
                    // Update UI on the main thread if necessary
//                    for park in parks {
//                        print("design a flat icon for \(park.nameCn)")
////                        // Access other properties of 'park' as needed
//                    }
                    completion(parks)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }

    
}
