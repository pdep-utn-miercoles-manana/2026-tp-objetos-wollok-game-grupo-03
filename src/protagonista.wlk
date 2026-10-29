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
      protagonista.decir("Que vas a decir? : [1] ¿Puedo ayudarte con algo? | [2] ¿Me acompanias? | [3] Como puedo escapar de aca?")
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
    ascensor.pisoActual().recibirAcompaniante(unProta.acompaniante(), unProta)
  }

  method abrirBotonera(unProta) {
    unProta.modo(modoBotonera)
    unProta.decir("A ver a donde puedo ir... tengo los pisos del 0 al 6 para viajar.")
  }

  method presionarNumero(numeroBoton, unProta) {} // En exploración los números no hacen nada, solo en modo botonera, inventario o dialogo

method presionarEnter(unProta) { // Limpia la caja de texto para que no moleste
  cajaDeTexto.ocultar()
}
}


object modoInventario {
  method iniciarDialogo(unProta) {} 
  method inspeccionarPiso(unProta) {}
  method presionarEnter(unProta) {}
  
  method abrirInventario(unProta) {
    unProta.modo(modoExploracion)
    unProta.decir("Cerré el inventario.")
  }
  
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}

  method presionarNumero(numeroElegido, unProta) {
    if (numeroElegido == 1 or numeroElegido == 2) {
      unProta.modo(modoExploracion) // Salgo del inventario primero
      const itemElegido = unProta.inventario().get(numeroElegido - 1)
      
      if (itemElegido != manosVacias) {
        itemElegido.usarEn(ascensor.pisoActual(), unProta) 
      } else {
        unProta.decir("No tengo nada para usar ahi, flashie")
      }
    } else {
      unProta.modo(modoExploracion)
      unProta.decir("No tengo nada para usar ahi, flashie")
    }
  }
}

object modoDialogo {
  method iniciarDialogo(unProta) {} // Ya estoy hablando, no puede hacer nada mas
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

object modoBotonera {
  method iniciarDialogo(unProta) {}  // Solo viaja a pisos, no puede interactuar con otra cosa que no sea la botonera
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method presionarEnter(unProta) {}
  
  method abrirBotonera(unProta) { // Si toco la B ya estando en modo botonera, vuelvo al modo normal (exploracion) para hacer otra cosa
    unProta.modo(modoExploracion)
    unProta.decir("Mejor miro que hay en este piso.")
  }

  method presionarNumero(numeroPisoElegido, unProta) {
    unProta.modo(modoExploracion) // Salgo de la botonera
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
    unProta.decir("Qué largo día en la oficina... Mejor toco la B y bajo a Planta Baja para ir a casa.")
  }

  method iniciarDialogo(unProta) {}
  method inspeccionarPiso(unProta) {}
  method abrirInventario(unProta) {}
  method mandarAcompaniante(unProta) {}
  method abrirBotonera(unProta) {}
  method presionarNumero(n, unProta) {}
}
object protagonista {

    var property inventario = [manosVacias, manosVacias] // va a tener que tratarse de un SET ya que puede tener varios items -- Preferimos usar listas ya que podemos acceder por indice al momento de querer usar los items y asignarlos a las teclas
    var property acompaniante = sinAcompaniante
    var property modo = modoPortada
    var property position = game.at(7, 1) // Posición donde va a salir la caja de texto

// Dialogo

method decir(unTexto) {
    console.println(unTexto) 
    cajaDeTexto.mostrarMensaje(unTexto)
  }

// Uso del inventario

    method tiene(item){
        return inventario.contains(item)
    }

    method tomarItem(item){
      if (!self.tiene(item) and self.tiene(manosVacias)) {
        if (inventario.get(0) == manosVacias) {
          const indiceLibre = inventario.indexOf(manosVacias)
          inventario.remove(manosVacias)
          inventario.add(item)
        } else {
          self.decir("No tengo más espacio en el inventario.")
        }
      }
    }

    method quitarItem(item){
      self.reemplazarItem(item, manosVacias)
    }

    method reemplazarItem(itemViejo, itemNuevo) {
    self.quitarItem(itemViejo)
    self.tomarItem(itemNuevo)
  }
  // Se delegan todo tema de teclas a los metodos
  method teclaEnter() { modo.presionarEnter(self) }
  method hablar() { modo.iniciarDialogo(self) }
  method inspeccionar() { modo.inspeccionarPiso(self) }
  method teclaInventario() { modo.abrirInventario(self) }
  method mandarAcompaniante() { modo.mandarAcompaniante(self) }
  method abrirBotonera() { modo.abrirBotonera(self) }
  method teclaNumero(numeroBoton) { modo.presionarNumero(numeroBoton, self) }

}

