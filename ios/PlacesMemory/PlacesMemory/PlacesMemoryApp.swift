import SwiftUI

@main
struct PlacesMemoryApp: App {
    @StateObject private var store = PlacesStore()
    @StateObject private var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            PlacesListView()
                .environmentObject(store)
                .environmentObject(locationManager)
        }
    }
}
