import MapKit
import SwiftUI

struct PlacesListView: View {
    @EnvironmentObject private var store: PlacesStore
    @State private var isAddingPlace = false

    var body: some View {
        NavigationStack {
            Group {
                if store.places.isEmpty {
                    ContentUnavailableView(
                        "Aún no tienes lugares",
                        systemImage: "map",
                        description: Text("Guarda una ubicación cuando pases por un sitio que quieras recordar.")
                    )
                } else {
                    List {
                        ForEach(store.places) { place in
                            NavigationLink {
                                PlaceDetailView(place: place)
                            } label: {
                                PlaceRow(place: place)
                            }
                        }
                        .onDelete(perform: store.delete)
                    }
                }
            }
            .navigationTitle("Mis lugares")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingPlace = true
                    } label: {
                        Label("Guardar lugar", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingPlace) {
                AddPlaceView()
            }
        }
    }
}

private struct PlaceRow: View {
    let place: Place

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: place.category.icon)
                .font(.title2)
                .foregroundStyle(.blue)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(place.title)
                    .font(.headline)
                Text(place.note)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                Text(place.createdAt, format: .dateTime.day().month().year().hour().minute())
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 4)
    }
}
