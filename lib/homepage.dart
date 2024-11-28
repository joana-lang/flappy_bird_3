import 'dart:async';
// Importa la biblioteca para manejar temporizadores (Timer).

import 'package:flutter/material.dart';
// Importa la biblioteca principal de Flutter para construir interfaces de usuario.

import 'bird.dart';
// Importa el widget personalizado para el pájaro. (Definido en otro archivo).

import 'barriers.dart';
// Importa el widget personalizado para las barreras. (Definido en otro archivo).

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  // Define el estado de la página principal como un widget con estado.
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  // La posición vertical del pájaro en el eje Y. Inicia en 0 (posición central).

  bool gameHasStarted = false;
  // Indica si el juego ha comenzado.

  double time = 0;
  // Controla el tiempo transcurrido desde el inicio del juego.

  double initialHeight = birdYaxis;
  // Altura inicial del pájaro, usada para calcular el movimiento.

  double barrierXone = 1.5;
  // Posición inicial de la primera barrera en el eje X.

  double barrierXtwo = 1.5;
  // Posición inicial de la segunda barrera en el eje X.

  Timer? gravityTimer;
  // Un temporizador para manejar la física (gravedad y ascenso/descenso).

  void startGravity({required bool upward}) {
    // Maneja el movimiento del pájaro (ascender o descender).
    stopGravity();
    // Detiene cualquier temporizador anterior antes de iniciar uno nuevo.

    gravityTimer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      // Crea un temporizador que se ejecuta cada 30 milisegundos.
      setState(() {
        if (upward) {
          birdYaxis -= 0.03;
          // Mueve el pájaro hacia arriba.
        } else {
          birdYaxis += 0.02;
          // Mueve el pájaro hacia abajo.
        }

        if (birdYaxis > 1 || checkCollision()) {
          // Si el pájaro toca el suelo o hay colisión, termina el juego.
          timer.cancel();
          endGame();
        }
      });
    });
  }

  void stopGravity() {
    gravityTimer?.cancel();
    // Detiene el temporizador de gravedad si está activo.
  }

  void startGame() {
    // Inicia el juego y mueve las barreras.
    gameHasStarted = true;
    // Cambia el estado del juego a "iniciado".

    Timer.periodic(Duration(milliseconds: 30), (timer) {
      // Crea un temporizador para mover las barreras periódicamente.
      setState(() {
        barrierXone -= 0.03;
        // Mueve la primera barrera hacia la izquierda.

        barrierXtwo -= 0.03;
        // Mueve la segunda barrera hacia la izquierda.

        if (barrierXone < -2) {
          barrierXone += 3.5;
          // Reinicia la posición de la primera barrera cuando sale de la pantalla.
        }

        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
          // Reinicia la posición de la segunda barrera cuando sale de la pantalla.
        }
      });

      if (checkCollision()) {
        // Termina el juego si hay colisión.
        timer.cancel();
        endGame();
      }
    });
  }

  bool checkCollision() {
    // Verifica si el pájaro colisiona con los límites o barreras.

    if (birdYaxis > 1 || birdYaxis < -1) {
      // Si el pájaro toca el suelo o el límite superior.
      return true;
    }

    const double birdWidth = 0.1;
    // Define el ancho del pájaro.

    // Verifica colisión con la primera barrera.
    if ((barrierXone < birdWidth && barrierXone > -birdWidth) &&
        (birdYaxis < -0.6 || birdYaxis > 0.6)) {
      return true;
    }

    // Verifica colisión con la segunda barrera.
    if ((barrierXtwo < birdWidth && barrierXtwo > -birdWidth) &&
        (birdYaxis < -0.7 || birdYaxis > 0.7)) {
      return true;
    }

    return false;
    // Si no hay colisión, devuelve `false`.
  }

  void endGame() {
    // Maneja el fin del juego.
    setState(() {
      gameHasStarted = false;
      // Cambia el estado del juego a "no iniciado".
    });

    stopGravity();
    // Detiene el temporizador de gravedad.

    showDialog(
      // Muestra un diálogo de "Game Over".
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Try again!"),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              // Reinicia el juego cuando el jugador presiona "Restart".
              Navigator.pop(context);
            },
            child: Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    // Reinicia el juego.
    setState(() {
      birdYaxis = 0;
      // Reinicia la posición del pájaro.

      barrierXone = 1.5;
      // Reinicia la posición de la primera barrera.

      barrierXtwo = barrierXone + 1.5;
      // Reinicia la posición de la segunda barrera.

      gameHasStarted = false;
      // Cambia el estado del juego a "no iniciado".
    });
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz gráfica del juego.
    return GestureDetector(
      onTapDown: (_) {
        // Detecta cuando el jugador toca la pantalla.
        if (!gameHasStarted) {
          startGame();
          // Inicia el juego si no ha comenzado.
        }
        startGravity(upward: true);
        // Hace que el pájaro ascienda.
      },
      onTapUp: (_) {
        // Detecta cuando el jugador deja de tocar la pantalla.
        startGravity(upward: false);
        // Hace que el pájaro descienda.
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              // La parte superior ocupa 2/3 de la pantalla.
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    // Coloca el pájaro según su posición en el eje Y.
                    duration: Duration(milliseconds: 0),
                    // Actualiza su posición inmediatamente.
                    color: Colors.blue,
                    // Fondo azul para el cielo.
                    child: MyBird(),
                    // Dibuja el pájaro.
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    // Muestra el texto "TAP TO PLAY" al centro.
                    child: gameHasStarted
                        ? SizedBox()
                        : Text(
                            "TAP TO PLAY",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    // Posición de la primera barrera (inferior).
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 100.0),
                    // Dibuja la barrera inferior.
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    // Posición de la primera barrera (superior).
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 180.0),
                    // Dibuja la barrera superior.
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    // Posición de la segunda barrera (inferior).
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 100.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    // Posición de la segunda barrera (superior).
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(size: 250.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              // Área verde entre el cielo y el suelo.
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                // Área marrón para el suelo.
                child: Center(
                  child: Text(
                    "FLAPPY BIRD",
                    // Muestra el texto del juego.
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
