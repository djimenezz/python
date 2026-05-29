import MapKit
import SwiftUI

struct PlaceDetailView: View {
    let place: Place

    @State private var position: MapCameraPosition

    init(place: Place) {
        self.place = place
        _position = State(initialValue: .region(MKCoordinateRegion(
            center: place.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Map(position: $position) {
                    Marker(place.title, systemImage: place.category.icon, coordinate: place.coordinate)
                }
                .frame(height: 260)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                VStack(alignment: .leading, spacing: 8) {
                    Label(place.category.rawValue, systemImage: place.category.icon)
                        .foregroundStyle(.blue)
                    Text(place.note)
                        .font(.body)
                    Text(place.createdAt, format: .dateTime.day().month().year().hour().minute())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Button {
                    openInMaps()
                } label: {
                    Label("Abrir en Mapas", systemImage: "map.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle(place.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func openInMaps() {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: place.coordinate))
        mapItem.name = place.title
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ])
    }
}
