import CoreLocation
import SwiftUI

struct AddPlaceView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: PlacesStore
    @EnvironmentObject private var locationManager: LocationManager

    @State private var title = ""
    @State private var category: PlaceCategory = .other
    @State private var note = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Lugar") {
                    TextField("Nombre breve", text: $title)
                    Picker("Tipo", selection: $category) {
                        ForEach(PlaceCategory.allCases) { category in
                            Label(category.rawValue, systemImage: category.icon)
                                .tag(category)
                        }
                    }
                    TextField("Nota para recordarlo", text: $note, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Ubicación actual") {
                    Button {
                        locationManager.requestCurrentLocation()
                    } label: {
                        Label("Actualizar mi ubicación", systemImage: "location.fill")
                    }

                    if let location = locationManager.currentLocation {
                        LabeledContent("Latitud", value: location.coordinate.latitude.formatted(.number.precision(.fractionLength(5))))
                        LabeledContent("Longitud", value: location.coordinate.longitude.formatted(.number.precision(.fractionLength(5))))
                    } else {
                        Text("Pulsa el botón para capturar el punto donde estás ahora.")
                            .foregroundStyle(.secondary)
                    }

                    if let errorMessage = locationManager.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Nuevo lugar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        savePlace()
                    }
                    .disabled(!canSave)
                }
            }
            .onAppear {
                locationManager.requestCurrentLocation()
            }
        }
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            locationManager.currentLocation != nil
    }

    private func savePlace() {
        guard let location = locationManager.currentLocation else { return }

        let place = Place(
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            category: category,
            note: note.trimmingCharacters(in: .whitespacesAndNewlines),
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        store.add(place)
        dismiss()
    }
}
