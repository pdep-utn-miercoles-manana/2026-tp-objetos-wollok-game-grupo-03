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

  method mostrarBotonera() {
    image = "botonera.png"
  }

  method mostrarFinal() {
    image = "final.png"
  }
}

class LineaDialogo {
  const property hablante
  const property texto
}

object retratoDialogo {
  var property position = game.at(1, 1)
  var property image = "cara_prota.png"
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
  var property position = game.at(0, 0)
  var visible = false
  const colaDeLineas = [] // Para tener una lista de dialogos y poder ir pasandolos para simular un dialogo

  method image() = "caja_dialogo.png"

  method mostrarMensaje(unHablante,unMensaje) {
    self.mostrarLinea(new LineaDialogo(hablante = unHablante, texto = unMensaje))
  }

  method iniciarConversacion(listaDeLineas, unProtagonista) {
    colaDeLineas.clear()
    colaDeLineas.addAll(listaDeLineas)
    unProtagonista.modo(modoConversacion)
    self.avanzarConversacion(unProtagonista)
  }

  method avanzarConversacion(unProtagonista) {
    if (not colaDeLineas.isEmpty()) {
      const siguienteLinea = colaDeLineas.first()
      colaDeLineas.remove(siguienteLinea)
      self.mostrarLinea(siguienteLinea)
    } else {
      self.ocultar()
      unProtagonista.modo(modoExploracion)
    }
  }

  method mostrarLinea(unaLinea) {
    textoDialogo.text(unaLinea.texto())
    retratoDialogo.image(unaLinea.hablante().retrato())

    if (not visible) {
      game.addVisual(self)
      game.addVisual(retratoDialogo)
      game.addVisual(textoDialogo)
      visible = true
    } else {
      // refresco por si no aparace la cara
      game.removeVisual(retratoDialogo)
      game.addVisual(retratoDialogo)
    }
  }

  method ocultar() {
    if (visible) {
      game.removeVisual(textoDialogo)
      game.removeVisual(retratoDialogo) // <-- SACAMOS EL RETRATO DE LA PANTALLA
      game.removeVisual(self)
      visible = false
    }
  }

  // Carga líneas secuenciales sin alterar el modo actual (ideal para el minijuego)
  method mostrarLineasMinijuego(listaDeLineas) {
    colaDeLineas.clear()
    colaDeLineas.addAll(listaDeLineas)
    self.avanzarLineaMinijuego()
  }

  method avanzarLineaMinijuego() {
    if (not colaDeLineas.isEmpty()) {
      const siguienteLinea = colaDeLineas.first()
      colaDeLineas.remove(siguienteLinea)
      self.mostrarLinea(siguienteLinea)
    }
  }
}

object textoDialogo {
  var property position = game.at(8, 1)
  var property text = ""
  var property textColor = "FFFFFF"
}

