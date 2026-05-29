import Combine
import Foundation

@MainActor
final class PlacesStore: ObservableObject {
    @Published private(set) var places: [Place] = []

    private let fileManager: FileManager
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
        load()
    }

    func add(_ place: Place) {
        places.insert(place, at: 0)
        save()
    }

    func delete(at offsets: IndexSet) {
        places.remove(atOffsets: offsets)
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: storageURL) else {
            places = []
            return
        }

        places = (try? decoder.decode([Place].self, from: data)) ?? []
    }

    private func save() {
        guard let data = try? encoder.encode(places) else { return }
        try? data.write(to: storageURL, options: [.atomic])
    }

    private var storageURL: URL {
        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent("places.json")
    }
}
