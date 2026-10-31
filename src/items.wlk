// Objetos del inventario (manosVacias, paraguasAntiguo, viniloDeCharly, carneDeLosBeatles, llaveMaestra) y acompañantes (sinAcompaniante, acompanianteTRex)
class Item {
  const property nombre
  method usarEn(piso, protagonista){
    piso.usarItem(self, protagonista)
  }
}

const libroAntiguo = new Item(nombre = "El Libro antiguo")
const bajoDePedroAznar = new Item(nombre = "El bajo de Pedro Aznar")
const carneDeLosBeattles = new Item(nombre = " Un churrasco de los Beattles")
const llaveMaestra = new Item(nombre = "La Llave Maestra")

// Objeto nulo polimórfico para representar el espacio libre del inventario
object  manosVacias inherits Item(nombre = "Nada") {
  override method usarEn(unPiso, unProtagonista) {
    unProtagonista.decir("No tengo nada para usar en ese espacio del inventario.")
  }
}

