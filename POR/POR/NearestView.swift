import SwiftUI
import CoreLocation
import MapKit

struct NearestView: View {
    
    @Binding var parks : [Park]
    @State var nearestPark : Park? = nil
    @StateObject var locationModel = LocationModel()
    
    var body: some View {
        
        NavigationView {
            
            if locationModel.authorizationStatus == .authorizedWhenInUse ||
                locationModel.authorizationStatus == .authorizedAlways {
                
                if let lastLocation = locationModel.lastLocation, let nearestPark = getNearestPark(location: lastLocation) {
                    
                    //Make it looks better
                    VStack {
                        Text("Surrounding Park")
                        Text("\(nearestPark.nameEn)")
                            .font(.headline)
                        
                        Button(action: {
                            
                            let destinationCoordinates = nearestPark.coordinate
                            
                            // Create a MKMapItem from the coordinates.
                            let placemark = MKPlacemark(coordinate: destinationCoordinates, addressDictionary: nil)
                            let mapItem = MKMapItem(placemark: placemark)
                            
                            // Set the launch options for the navigation mode.
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
                            
                            // Open in Maps app and start navigation.
                            mapItem.openInMaps(launchOptions: launchOptions)
                            
                        },
                               label: {
                            Label("Navi", systemImage: "bus.doubledecker.fill")
                            
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                        .navigationTitle("Surrounding Park")
                } else {
                    Text("No Nearest Park")
                        .navigationTitle("Surrounding Park")
                }
            } else {
                Text("No Location Avaliable !!")
                    .foregroundStyle(.red)
            }
        } .onAppear() {
            locationModel.requestPermission()
        }
    }
    
    func getNearestPark(location : CLLocation) -> Park? {
        
        guard var nearestPark = parks.first else {
            return nil
        }
        
        for park in parks {
            nearestPark = CLLocation(latitude: park.latitude.toDecimalDegrees() ?? 0.0, longitude: park.longitude.toDecimalDegrees() ?? 0.0).distance(from: location) < CLLocation(latitude: nearestPark.latitude.toDecimalDegrees() ?? 0.0, longitude: nearestPark.longitude.toDecimalDegrees() ?? 0.0).distance(from: location) ? park : nearestPark
            return nearestPark
        }
        return nil
    }
    
}

struct NearestView_Preview : PreviewProvider {
    static var previews: some View {
        NearestView(parks: .constant([]))
    }
}

