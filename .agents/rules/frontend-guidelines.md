# Instrucciones Generales para la Inteligencia Artificial (Antigravity) - Frontend

Este archivo contiene las directrices, reglas de estilo y buenas prácticas que debes seguir estrictamente cuando trabajes en la aplicación móvil de este workspace (`PetCareMobile`).

## 1. Arquitectura y Gestión del Estado
- **Feature-First / Clean Architecture:** Mantén la estructura basada en funcionalidades (`lib/features/...`). Separa estrictamente la presentación (UI) de la lógica de dominio (modelos/DTOs) y el acceso a datos (repositorios).
- **Gestión de Estado con Riverpod:** Prohibido usar `setState` para estados complejos o globales. Todo el estado de la aplicación, el cacheo de peticiones y la inyección de dependencias deben manejarse exclusivamente con `@riverpod` y `ConsumerWidget`.
- **Modelos Inmutables (Freezed):** Es obligatorio usar el paquete `Freezed` y `json_serializable` para definir las clases de datos (DTOs) asegurando inmutabilidad, copias seguras (`copyWith`) y una correcta comunicación JSON con la API.

## 2. Pautas de Interfaz (UI/UX)
- **Cohesión Implacable en Listados:** Se debe seguir SIEMPRE el mismo estilo de diseño base entre todas las tarjetas (cards) de listados de la aplicación para garantizar que el diseño sea coherente, predecible y ofrezca una cohesión visual impecable en todas las pantallas.
- **Diseño Limpio y Profesional:** Todos los desarrollos de interfaz tienen que tener una apariencia limpia, profesional, moderna/actual y ser `mobileFriendly`. Evita interfaces saturadas, respeta los márgenes (padding) y emplea elevaciones o bordes sutiles.
- **Detalles Premium:** Apuesta por estéticas modernas (Material 3), bordes redondeados consistentes, uso de *chips* o *botones dinámicos* para selecciones, e incluye siempre micro-animaciones para mejorar el *feedback* al usuario cuando interactúe.
- **Mobile First & Responsive:** Todas las pantallas deben diseñarse pensando primero en dispositivos móviles, asegurando que los teclados virtuales no oculten campos de texto importantes (usa vistas con scroll) y priorizando modales inferiores (`BottomSheets`) para flujos secundarios en lugar de diálogos disruptivos.

## 3. Flujo de Trabajo y Herramientas
- **Control de Versiones (Git):** NUNCA ejecutes `git commit`, `git push` ni generes una Pull Request (PR) automáticamente a menos que yo te lo indique explícitamente. Limítate a escribir el código y esperar mi confirmación.
- **Generación de Código Automática:** Recuerda SIEMPRE ejecutar `dart run build_runner build -d` cada vez que modifiques o crees un modelo `Freezed`, un proveedor `Riverpod` o llamadas de red con generación de código.
- **Enrutamiento Centralizado:** Utiliza exclusivamente `GoRouter` para la navegación de la aplicación y pasa siempre parámetros a las rutas a través del sistema de enrutamiento fuertemente tipado si es posible.
