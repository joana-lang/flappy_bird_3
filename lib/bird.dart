// Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas
// esenciales para construir interfaces de usuario en Flutter.
import 'package:flutter/material.dart';

// Define una clase llamada 'MyBird', que extiende 'StatelessWidget'.
// Esto significa que este widget es inmutable y no tiene estado.
class MyBird extends StatelessWidget {
  // Sobrescribe el método 'build', que es obligatorio en los widgets.
  // Este método devuelve la representación visual del widget.
  @override
  Widget build(BuildContext context) {
    // Retorna un widget 'Container', que se utiliza para organizar y personalizar
    // el diseño y tamaño de un widget hijo.
    return Container(
        // Define una altura fija para el 'Container' de 60 unidades.
        height: 60,
        // Define un ancho fijo para el 'Container' de 60 unidades.
        width: 60,
        // Agrega un widget hijo dentro del 'Container'. En este caso, es una imagen
        // que se carga utilizando 'Image.asset', que permite cargar imágenes
        // desde los recursos del proyecto.
        child: Image.asset('lib/images/flappybird.png'));
  }
}
