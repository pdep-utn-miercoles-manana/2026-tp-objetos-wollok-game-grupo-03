import items.*
import personajes.*
import ascensor.*
// Objeto protagonista y modos de interacción (modoExploracion, modoDialogo, modoBotonera, etc.)
object protagonista {

    var property inventario = [manosVacias, manosVacias] // va a tener que tratarse de un SET ya que puede tener varios items
    var property acompaniante = sinAcompaniante
    //var property modo = modoBotonera 

    method tiene(item){
        return inventario.contains(item)
    }

    method tomarItem(item){
      if (!self.tiene(item) and self.tiene(manosVacias)) {
        if (inventario.get(0) == manosVacias) {
          inventario = [item, inventario.get(1)]
        } else {
          inventario = [inventario.get(0), item]
        }
      }
    }

    method quitarItem(item){
      self.reemplazarItem(item, manosVacias)
    }

    method reemplazarItem(item1, item2){
      if (self.tiene(item1)) {
        inventario = inventario.map({ unItem => if (unItem == item1) item2 else unItem })
      }
    }

    method nombresDeItems() {
        inventario.map({item => item.nombre()})
    }

    method interactuar() {
    const alguien = ascensor.pisoActual().personaje()
    if (alguien != null) {
      alguien.interactuar() // Habla directo con el personaje
    }
  }

// podemos delegar al personaje del piso averiguar si tiene el item que necesita
    method usarItem(unItem) {
    if (self.tiene(unItem)) {
      const alguien = ascensor.pisoActual().personaje()
      if (alguien != null) {
        alguien.recibirItem(unItem, self) // Le entrega el ítem directo al personaje
      }
    }
  }

  // Controles de acción del usuario
  method teclaInspeccionar() {}

  method teclaUsarItem() {}

  method teclaMandarAcompaniante() {}

  method teclaBotonera() {
     ascensor.abrirBotonera()
  }

  // Teclas numéricas
  method teclaNumero(numero) {
    if (ascensor.botoneraAbierta()) {
      ascensor.botonPresionado(numero)
    } else {
      ascensor.pisoActual().responder(numero)
    }
  }
  
  method usarEspacio(numero) {
    const item = self.inventario().get(numero)
    const piso = ascensor.pisoActual()
    item.usarEn(piso, self)
  }

  method decir(mensaje) {}

}

