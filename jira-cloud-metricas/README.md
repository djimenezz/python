# Jira Cloud Métricas

Pequeño esqueleto para comenzar a experimentar con la API de Jira Cloud.

## Requisitos

- Python 3.10+
- [pip](https://pip.pypa.io/)

## Instalación

```bash
python -m venv .venv
source .venv/bin/activate  # En Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
```

## Configuración

1. Copia el archivo `.env.example` a `.env`.
2. Actualiza las variables con tus credenciales de Jira Cloud.

## Uso

```bash
python -m jira_client.main
```

El script cargará las credenciales desde el entorno y mostrará un mensaje
indicando si la configuración es válida.

## Próximos pasos

- Añadir un cliente real para consultar métricas.
- Incluir pruebas automáticas en el directorio `tests/`.
