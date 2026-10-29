import wollok.game.*
import protagonista.*
import ascensor.*

object visorDePantalla {
  var property position = game.at(0, 0)
  var property image = "portada.png" // Arranca con la imagen del edificio de Sancor Seguros

  method mostrarIntro() {
    image = "intro.png" // Segunda imagen con la descripción del juego
  }

  method mostrarPisoActual() {
    image = ascensor.pisoActual().imagen() // Muestra el .png del piso donde esté el ascensor
  }
}

object juego {
  method iniciar() {
    game.title("Ascensor Dimensional")
    game.width(15)
    game.height(10)
    game.cellSize(64)
    
// Agregamos primero el visor de pantalla para que quede de fondo
    game.addVisual(visorDePantalla)


// Tecla ENTER para avanzar en las pantallas de inicio
    keyboard.enter().onPressDo({ protagonista.teclaEnter() })

// Controles de acción principal
    keyboard.h().onPressDo({ protagonista.hablar() })
    keyboard.i().onPressDo({ protagonista.inspeccionar() })
    keyboard.e().onPressDo({ protagonista.teclaInventario() })
    keyboard.a().onPressDo({ protagonista.mandarAcompaniante() })
    keyboard.b().onPressDo({ protagonista.abrirBotonera() })

// Teclas numéricas universales (delegan en el modo actual)
    keyboard.num0().onPressDo({ protagonista.teclaNumero(0) })
    keyboard.num1().onPressDo({ protagonista.teclaNumero(1) })
    keyboard.num2().onPressDo({ protagonista.teclaNumero(2) })
    keyboard.num3().onPressDo({ protagonista.teclaNumero(3) })
    keyboard.num4().onPressDo({ protagonista.teclaNumero(4) })
    keyboard.num5().onPressDo({ protagonista.teclaNumero(5) })
    keyboard.num6().onPressDo({ protagonista.teclaNumero(6) })
    
    game.start()
  }
}

object cajaDeTexto {
  var property position = game.at(1, 0)
  var visible = false

  method image() = "caja_dialogo.png"

  method mostrarMensaje(unMensaje) {
    textoDialogo.text(unMensaje)
    if (not visible) {
      game.addVisual(self)
      game.addVisual(textoDialogo) // Se agrega después para dibujarse arriba de la caja
      visible = true
    }
  }

  method ocultar() {
    if (visible) {
      game.removeVisual(textoDialogo)
      game.removeVisual(self)
      visible = false
    }
  }
}

object textoDialogo {
  // Posición centrada horizontalmente (7) y a mitad de altura de la caja (1)
  var property position = game.at(7, 1)
  var property text = ""
  var property textColor = "FFFFFF"
}