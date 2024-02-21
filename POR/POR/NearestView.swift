import SwiftUI
import CoreLocation
import MapKit

struct NearestView: View {
    @Binding var parks: [Park]
    @State var nearestPark: Park? = nil
    @StateObject var locationModel = LocationModel()
    
    var body: some View {
        NavigationView {
            if locationModel.authorizationStatus == .authorizedWhenInUse ||
                locationModel.authorizationStatus == .authorizedAlways {
                if let lastLocation = locationModel.lastLocation, let nearestPark = getNearestPark(location: lastLocation) {
                    VStack {
                        Text("Nearest Park")
                            .font(.headline)
                        Text("\(nearestPark.nameEn)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        Button(action: {
                            navigateToNearestPark(nearestPark: nearestPark)
                        }) {
                            Label("Navigate", systemImage: "location.fill")
                                .font(.title)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .padding()
                    }
                    .navigationTitle("Nearest Park")
                } else {
                    Text("No Nearest Park")
                        .navigationTitle("Nearest Park")
                }
            } else {
                Text("No Location Available")
                    .navigationTitle("Nearest Park")
            }
        }
        .onAppear {
            locationModel.requestPermission()
        }
    }
    
    func getNearestPark(location: CLLocation) -> Park? {
        var nearestPark: Park? = nil
        var nearestDistance: CLLocationDistance = Double.infinity
        
        for park in parks {
            let latitude = park.latitude
            let longitude = park.longitude
            
            let parkLocation = CLLocation(latitude: Double(latitude) ?? 0.0, longitude: Double(longitude) ?? 0.0)
            let distance = parkLocation.distance(from: location)
            
            if distance < nearestDistance {
                nearestPark = park
                nearestDistance = distance
            }
        }
        
        return nearestPark
    }
    
    func navigateToNearestPark(nearestPark: Park) {
        let latitudeDouble = Double(nearestPark.latitude)!
        let longitudeDouble = Double(nearestPark.longitude)!
        
        let destinationCoordinates = CLLocationCoordinate2D(latitude: latitudeDouble, longitude: longitudeDouble)
        let placemark = MKPlacemark(coordinate: destinationCoordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = nearestPark.nameEn
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    struct NearestView_Previews: PreviewProvider {
        static var previews: some View {
            NearestView(parks: .constant([]))
        }
    }
}
