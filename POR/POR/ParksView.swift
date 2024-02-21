//
//  ParksView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

let hkDistricts: [String: String] = [
    "Central and Western": "CW",
    "Eastern": "ED",
    "Southern": "SD",
    "Wan Chai": "WC",
    "Sham Shui Po": "SSP",
    "Kowloon City": "KC",
    "Kwun Tong": "KT",
    "Wong Tai Sin": "WTS",
    "Yau Tsim Mong": "YTM",
    "Islands": "IL",
    "Kwai Tsing": "KT",
    "North": "ND",
    "Sai Kung": "SK",
    "Sha Tin": "ST",
    "Tai Po": "TP",
    "Tsuen Wan": "TW",
    "Tuen Mun": "TM",
    "Yuen Long": "YL"
]

func getURL(district : String, name : String) -> String {
    //https://www.lcsd.gov.hk/file_upload_clpss/leisure_facilities/en/common/images/photo/facilities/ED/1106_2.jpg
    var baseURL = "https://www.lcsd.gov.hk/file_upload_clpss/leisure_facilities/en/common/images/photo/facilities/"
    
    //https://www.lcsd.gov.hk/en/parks/cwdpc/common/graphics/cwdpc_01.jpg
    print("\(baseURL)\(district)/\(name)")
    return "\(baseURL)\(district)/\(name)"
}

struct ParksView: View {
    @Binding var parks : [Park]
    @State var navigationPath = [Park]()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Color.teal.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            List(parks) {
                park in
                
                //this is for designing the row UI of the the park list
                //start
                NavigationLink(value: park, label: {
                    HStack {
                    if let districtEn = hkDistricts[park.districtEn] {
                        AsyncImage(url: URL(string: getURL(district: districtEn, name: park.photo1)), content: {
                            image in
                            
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 100)
                            
                        }, placeholder: {
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 120, height: 100)
                        })
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    } else {
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 120, height: 100)
                    }
                    VStack (alignment: .leading) {
                        Text("\(park.nameEn)")
                            .font(.headline)
                        Text("\(park.addressEn)")
                            .font(.footnote)
                    }
                }

                })
                //end
                
            }
            .listStyle(.grouped)
            .navigationTitle("List of Park")
            
            .navigationDestination(for: Park.self, destination: {
                park in
                
                ParkView(park: park)
            })
        }
    }
}

struct ParksView_Preview : PreviewProvider {
    @State static var parks = [Park]()
    static var previews: some View {
        ParksView(parks: $parks)
    }
}
