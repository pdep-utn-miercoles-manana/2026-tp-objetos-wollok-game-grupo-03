import items.*
import personajes.*
import ascensor.*
// Objeto protagonista y modos de interacción (modoExploracion, modoDialogo, modoBotonera, etc.)
object protagonista {

    var property inventario = #{} // va a tener que tratarse de un SET ya que puede tener varios items
    var property acompaniante = sinAcompaniante
    //var property modo = modoBotonera 

    method tiene(item){
        return inventario.contains(item)
    }

    method tomarItem(item){
        inventario.add(item)
    }

    method quitarItem(item){
        if(self.tiene(item)){
            inventario.remove(item)
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

/*
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
  */

}

