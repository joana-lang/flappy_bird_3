// Importa el paquete 'flutter/material.dart', que contiene widgets y herramientas
// esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';

// Define una clase 'MyBarrier' que extiende 'StatelessWidget',
// indicando que el widget no tendrá un estado mutable.
class MyBarrier extends StatelessWidget {
  // Define un campo final llamado 'size', que almacenará el tamaño de la barrera.
  // Este valor será proporcionado al crear una instancia de 'MyBarrier'.
  final size;

  // Constructor de la clase 'MyBarrier', que permite inicializar el campo 'size'.
  // La sintaxis '{this.size}' indica que 'size' es un parámetro opcional nombrado.
  MyBarrier({this.size});

  // Sobrescribe el método 'build', que es obligatorio en los widgets.
  // Este método devuelve la representación visual del widget.
  @override
  Widget build(BuildContext context) {
    // Retorna un widget 'Container', que es un widget versátil para
    // crear diseños personalizados. Aquí se utiliza para crear la barrera.
    return Container(
      // Define el ancho fijo del 'Container' como 80 unidades.
      width: 80,
      // Define la altura del 'Container', usando el valor proporcionado en 'size'.
      height: size,
      // Agrega un decorado al 'Container' con 'BoxDecoration'.
      decoration: BoxDecoration(
        // Establece el color de fondo del 'Container' a verde.
        color: Colors.green,
        // Agrega un borde alrededor del 'Container' con un ancho de 10 unidades
        // y un color específico definido por un valor ARGB.
        border: Border.all(
          width: 10,
          color: const Color.fromARGB(255, 13, 91, 17),
        ),
        // Agrega esquinas redondeadas al 'Container' con un radio de 15 unidades.
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
