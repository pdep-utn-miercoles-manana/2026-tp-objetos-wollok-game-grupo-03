import wollok.game.*
import items.*
import personajes.*
import ascensor.*
import juego.*
// Objeto protagonista y modos de interacción (modoExploracion, modoDialogo, modoBotonera, etc.)

// MODOS del protagonista - POLIMORFICOS

object modoExploracion {
  method iniciarDialogo(protagonista) {
    protagonista.modo(modoDialogo)
    protagonista.decir("Que puedo decir? : [1] ¿Puedo ayudarte con algo? | [2] ¿Me acompañás a otro piso? | [3] ¿Como puedo escapar de acá?")
  }

  method inspeccionarPiso(protagonista) {
    protagonista.decir(ascensor.pisoActual().inspeccionar())
  }

  method abrirInventario(unProta) {
    unProta.modo(modoInventario)
    const item1 = unProta.inventario().get(0).nombre()
    const item2 = unProta.inventario().get(1).nombre()
    unProta.decir("Tengo las siguientes cosas para usar: [1] " + item1 + " | [2] " + item2)
  }

  method mandarAcompaniante(unProta) {
    ascensor.pisoActual().recibirAcompañante(unProta.acompañante(), unProta)
  }

  method abrirBotonera(unProta) {
    unProta.modo(modoBotonera)
    visorDePantalla.mostrarBotonera()
    unProta.decir("A ver a donde puedo ir... tengo los pisos del 0 al 6 para viajar. (Usa la tecla B para ver la botonera del ascensor)")
  }

  method presionarNumero(numeroBoton, unProta) {} // En exploración los números no hacen nada, solo en modo botonera, inventario o dialogo.

  method presionarEnter(unProta) {          // Limpia la caja de texto para que no moleste
    cajaDeTexto.ocultar()
  }
}


object modoInventario {
  method iniciarDialogo(unProta) {}  // No hacen nada cuando se mira el inventario
  method inspeccionarPiso(unProta) {}
  method presionarEnter(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  
  method abrirInventario(unProta) { // Apretando la tecla de lo que se quiere hacer (botonera,dialogo, etc), permite cerrar la opción y volver al modo exploracion
    unProta.modo(modoExploracion)
    unProta.decir("Cerré el inventario, mejor no uso nada acá.")
  }
  
  method presionarNumero(numeroElegido, unProta) {
   unProta.modo(modoExploracion) // Salgo del inventario
    if (numeroElegido == 1 or numeroElegido == 2) {
      const itemElegido = unProta.inventario().get(numeroElegido - 1)
      itemElegido.usarEn(ascensor.pisoActual(), unProta) // Polimorfismo puro
    } else {
      unProta.decir("No tengo nada para usar ahi, flashie.")
    }
  }
}

object modoDialogo {
  method iniciarDialogo(unProta) {} // Ya está hablando el protagonista, no puede hacer nada mas
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarEnter(unProta) {}

  method presionarNumero(numeroElegido, unProta) {
    if (numeroElegido >= 1 and numeroElegido <= 3) {
      unProta.modo(modoExploracion) // Salgo del diálogo
      // El piso es el intermediario de la conversación
      ascensor.pisoActual().hablarConPersonaje(numeroElegido, unProta) 
    }
  }
}

object modoConversacion {
  // Cada vez que apretás ENTER, pasa a la siguiente frase de la charla
  method presionarEnter(unProta) {
    cajaDeTexto.avanzarConversacion(unProta)
  }

  // Bloquea las demás acciones hasta que termine el ida y vuelta
  method iniciarDialogo(unProta) {}
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarNumero(n, unProta) {}
}

object modoBotonera {
  method iniciarDialogo(unProta) {}  // Solo viaja a pisos, no puede interactuar con otra cosa que no sea la botonera
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method presionarEnter(unProta) {}
  
  method abrirBotonera(unProta) { // Si toco la B ya estando en modo botonera, vuelvo al modo normal (exploracion) para hacer otra cosa
    unProta.modo(modoExploracion)
    visorDePantalla.mostrarPisoActual()
    unProta.decir("Mejor miro que hay en este piso.")
  }

  method presionarNumero(numeroPisoElegido, unProta) {
    unProta.modo(modoExploracion) // Salgo de la botonera
    visorDePantalla.mostrarPisoActual()
    ascensor.botonPresionado(numeroPisoElegido) // Viajo
  }
}

object modoPortada {
  method presionarEnter(unProta) {
    visorDePantalla.mostrarIntro()
    unProta.modo(modoIntro)
  }

  // Mientras está en la portada, las demás teclas están desactivadas
  method iniciarDialogo(unProta) {}
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarNumero(n, unProta) {}
}

object modoIntro {
  method presionarEnter(unProta) {
    visorDePantalla.mostrarPisoActual() // Pasa a mostrar el Piso 6 (Oficina)
    unProta.modo(modoExploracion)       // Habilita los controles del juego
    unProta.decir("Qué largo día en la oficina che... mejor ya bajo a Planta Baja para ir a casa. (Tecla B para ver la botonera del ascensor)")
  }

  method iniciarDialogo(unProta) {} // No hace nada, es solo la introduccion
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarNumero(n, unProta) {}
}

// Para la parte del recital de charly
object modoMinijuego {
  method iniciarDialogo(unProta) {}
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarEnter(unProta) {}

  method presionarNumero(numeroElegido, unProta) {
    if (numeroElegido >= 1 and numeroElegido <= 3) {
      unProta.modo(modoExploracion)
      ascensor.pisoActual().responderMinijuego(numeroElegido, unProta)
    }
  }
}

object modoFinDelJuego {
  method iniciarDialogo(unProta) {}
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarEnter(unProta) {}
  method presionarNumero(numeroElegido, unProta) {}
}
object protagonista {

    var property inventario = [manosVacias, manosVacias] // va a tener que tratarse de un SET ya que puede tener varios items -- Preferimos usar listas ya que podemos acceder por indice al momento de querer usar los items y asignarlos a las teclas
    var acompaniante = sinAcompaniante
    var property modo = modoPortada

    method retrato() = "cara_prota.png"

// Dialogo

method decir(unTexto) {
    console.println(unTexto) // para debug asi sale por consola
    cajaDeTexto.mostrarMensaje(unTexto) // sale en la caja de dialogo del juego
  }

method conversar(listaDeLineas) {
    cajaDeTexto.iniciarConversacion(listaDeLineas, self)
  }

// Uso del inventario

    method tiene(item) = inventario.contains(item)

    method tomarItem(item){       // Usado cuando le dan los items
      if (!self.tiene(item) and self.tiene(manosVacias)) {
          inventario.remove(manosVacias)
          inventario.add(item)
      } else if (!self.tiene(manosVacias)) {
          self.decir("No tengo más espacio en el inventario.")
        }
    }

    method quitarItem(item){
      self.reemplazarItem(item, manosVacias)
    }

    method reemplazarItem(itemViejo, itemNuevo) {
    self.quitarItem(itemViejo)
    self.tomarItem(itemNuevo)
  }
  // Se delegan todo tema de teclas al modo que tenga el protagonista
  method teclaEnter() { modo.presionarEnter(self) }
  method hablar() { modo.iniciarDialogo(self) }
  method inspeccionar() { modo.inspeccionarPiso(self) }
  method teclaInventario() { modo.abrirInventario(self) }
  method mandarAcompaniante() { modo.mandarAcompaniante(self) }
  method abrirBotonera() { modo.abrirBotonera(self) }
  method teclaNumero(numeroBoton) { modo.presionarNumero(numeroBoton, self) }

}

