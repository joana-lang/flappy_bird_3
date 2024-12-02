// Importa el archivo 'homepage.dart', que contiene la definición del widget `HomePage`.
// Este archivo está ubicado en el paquete `flappy_bird_3`.
import 'package:flappy_bird_3/homepage.dart';

// Importa el paquete 'flutter/material.dart', que incluye widgets y herramientas
// esenciales para construir interfaces de usuario con Material Design.
import 'package:flutter/material.dart';

// Define la función principal de la aplicación. Es el punto de entrada de ejecución
// de cualquier aplicación Flutter.
void main() {
  // void main- vacio principal
  // Llama a la función `runApp`, que inicia la aplicación Flutter.
  // Toma el widget raíz de la aplicación (en este caso, `MyApp`) y lo dibuja en pantalla.
  runApp(MyApp());
}

// Define una clase llamada `MyApp`, que extiende `StatelessWidget`.
// Esto indica que el widget es inmutable (no tiene estado que cambie dinámicamente).
class MyApp extends StatelessWidget {
  // Sobrescribe el método `build`, que construye y devuelve la interfaz de usuario de este widget.
  @override
  Widget build(BuildContext context) {
    // Retorna un widget `MaterialApp`, que es el contenedor principal de la aplicación.
    return MaterialApp(
      // Oculta el banner de depuración (un texto "Debug" en la esquina superior derecha)
      // que aparece durante el desarrollo.
      debugShowCheckedModeBanner: false, //depuraciónMostrarBannerModoControlado
      // Define el widget inicial que se mostrará al abrir la aplicación.
      // En este caso, el widget inicial es `HomePage`, definido en `homepage.dart`.
      home: HomePage(),
    );
  }
}
