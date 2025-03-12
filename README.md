# Aplicación de Escaneo de Códigos QR con Autenticación Biométrica

## Descripción del Proyecto

Este proyecto es el resultado de un **Reto de Codificación** donde se requiere desarrollar una aplicación móvil en **Flutter** que permita a los usuarios escanear códigos QR utilizando la cámara del dispositivo. Además, la aplicación incluye una funcionalidad de **autenticación biométrica**, soportando tanto **Face ID** en iOS como **huella digital** en Android, brindando una capa adicional de seguridad.

El principal objetivo de la aplicación es proporcionar una experiencia fluida y optimizada para escanear códigos QR y acceder a la información de manera sencilla y rápida. Además, se ha implementado un sistema de historial para almacenar los códigos QR escaneados, con persistencia incluso después de cerrar la aplicación.

### Características

- **Escaneo de Códigos QR:**
  - La cámara se activa automáticamente al abrir la pantalla de escaneo.
  - Los datos escaneados se muestran en pantalla y se almacenan en un historial persistente.

- **Autenticación Biométrica:**
  - Al iniciar la aplicación, se ofrece la opción de autenticarse mediante Face ID (iOS) o huella digital (Android).
  - Si el dispositivo no es compatible o la autenticación biométrica falla, se solicita un PIN de respaldo.

### Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil para crear aplicaciones nativas para Android e iOS.

- **BLoC**: Gestión de estado con el patrón BLoC para manejar el flujo de datos en la aplicación de forma eficiente y escalable.

- **Riverpod**: Implementación de gestión de estado para facilitar la inyección de dependencias y asegurar una arquitectura limpia.

- **Isar**: Utilizado para la persistencia de datos (historial de códigos QR escaneados).

- **Autenticación Biométrica**: Integración para Face ID y huella digital utilizando paquetes de Flutter.

### Arquitectura

Se ha seguido una **arquitectura limpia** (Clean Architecture) para separar las preocupaciones y garantizar que el código sea escalable, mantenible y fácil de probar. La aplicación se organiza en capas, cada una con responsabilidades bien definidas:

1. **Presentación**: Maneja la interfaz de usuario, incluyendo los widgets y la lógica de la vista.

2. **Infrastucture**: Contiene la lógica de negocio principal, que en este caso incluye la lógica para manejar el escaneo de códigos QR y la autenticación biométrica.

3. **Domain**: Gestiona la interacción con las fuentes de datos, incluyendo Isar para la persistencia del historial de códigos QR escaneados.

### Instalación

1. Clona este repositorio en tu máquina local:
   ```bash
   git clone https://github.com/carlosdiazz/flutter_qr.git

2. Instala las dependencias de Flutter:
   ```bash
   flutter pub get


3. Ejecuta la aplicación en un emulador o dispositivo físico:
   ```bash
   flutter run

### Login (Demo)

En caso de que el dipositivo no cuente con Autenticación Biométrica, puede iniciar con un codigo de prueba que es **test1234**

Esta clave se creo solo con el fin de prueba, para un caso ideal lo correcto seria primero registrar una clave, para luego utilizarla.