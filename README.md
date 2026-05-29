# PlacesMemory

Prototipo de app iOS para guardar lugares de interés mientras caminas por una ciudad. La idea es poder abrir la app, capturar la ubicación actual, añadir una nota y encontrar ese punto más adelante en una lista o en Apple Maps.

## Funcionalidades incluidas

- Guardar un lugar con nombre, categoría, nota y coordenadas GPS actuales.
- Solicitar permiso de ubicación solo cuando se necesita capturar un punto.
- Persistir los lugares localmente en un archivo JSON dentro del directorio de documentos de la app.
- Ver los lugares guardados en una lista cronológica.
- Abrir el detalle de un lugar con mapa, nota, categoría y botón para navegar en Apple Maps.
- Eliminar lugares desde la lista.

## Estructura

```text
ios/PlacesMemory/
├── project.yml                  # Configuración para generar el proyecto Xcode con XcodeGen
└── PlacesMemory/
    ├── Info.plist
    ├── PlacesMemoryApp.swift
    ├── Models/Place.swift
    ├── Services/LocationManager.swift
    ├── Services/PlacesStore.swift
    └── Views/
        ├── AddPlaceView.swift
        ├── PlaceDetailView.swift
        └── PlacesListView.swift
```

## Cómo abrirlo en Xcode

Este repositorio incluye un `project.yml` para generar el proyecto con [XcodeGen](https://github.com/yonaskolb/XcodeGen):

```bash
cd ios/PlacesMemory
xcodegen generate
open PlacesMemory.xcodeproj
```

Después, selecciona un simulador o un iPhone físico y ejecuta la app desde Xcode. Para probar la captura real de coordenadas es recomendable usar un dispositivo físico o configurar una ubicación simulada en el simulador.

## Próximos pasos recomendados

- Añadir búsqueda y filtros por categoría.
- Permitir adjuntar fotos a cada lugar.
- Añadir etiquetas personalizadas.
- Sincronizar con iCloud para conservar lugares entre dispositivos.
- Crear recordatorios o rutas de visita por cercanía.
