//
//  Park.swift
//  LetsGoPlay
//
//  Created by ituser on 1/5/24.
//

import Foundation
import CoreLocation

// Define the Codable struct to match the JSON structure
struct Park: Codable, Identifiable, Hashable {
    let id = UUID()
    let districtEn: String
    let districtCn: String
    let nameEn: String
    let nameCn: String
    let addressEn: String
    let addressCn: String
    let gihs: String
    let facilitiesEn: String
    let facilitiesB5: String
    let phone: String
    let photo1: String
    let photo2: String
    let photo3: String?
    let photo4: String?
    let longitude: String
    let latitude: String

    enum CodingKeys: String, CodingKey {
        case districtEn = "District_en"
        case districtCn = "District_cn"
        case nameEn = "Name_en"
        case nameCn = "Name_cn"
        case addressEn = "Address_en"
        case addressCn = "Address_cn"
        case gihs = "GIHS"
        case facilitiesEn = "Facilities_en"
        case facilitiesB5 = "Facilities_b5"
        case phone = "Phone"
        case photo1 = "Photo_1"
        case photo2 = "Photo_2"
        case photo3 = "Photo_3"
        case photo4 = "Photo_4"
        case longitude = "Longitude"
        case latitude = "Latitude"
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude.toDecimalDegrees()  ?? 0,
            longitude: longitude.toDecimalDegrees()  ?? 0
        )
    }
}


extension String {
    func toDecimalDegrees() -> Double? {
        let components = self.split(separator: "-")
        guard components.count == 3,
              let degrees = Double(components[0]),
              let minutes = Double(components[1]),
              let seconds = Double(components[2]) else {
            return nil
        }

        // Convert the latitude to decimal format
        let decimalDegrees = degrees + (minutes / 60) + (seconds / 3600)
        return decimalDegrees
    }
}
