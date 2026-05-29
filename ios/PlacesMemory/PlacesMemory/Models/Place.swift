import Foundation
import CoreLocation

struct Place: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var category: PlaceCategory
    var note: String
    var latitude: Double
    var longitude: Double
    var createdAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        category: PlaceCategory,
        note: String,
        latitude: Double,
        longitude: Double,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.note = note
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

enum PlaceCategory: String, CaseIterable, Codable, Identifiable {
    case cafe = "Café"
    case restaurant = "Restaurante"
    case shop = "Tienda"
    case viewpoint = "Mirador"
    case culture = "Cultura"
    case other = "Otro"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .cafe:
            return "cup.and.saucer.fill"
        case .restaurant:
            return "fork.knife"
        case .shop:
            return "bag.fill"
        case .viewpoint:
            return "binoculars.fill"
        case .culture:
            return "theatermasks.fill"
        case .other:
            return "mappin.circle.fill"
        }
    }
}
