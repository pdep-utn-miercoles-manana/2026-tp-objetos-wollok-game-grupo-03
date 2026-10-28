// Objetos del inventario (manosVacias, paraguasAntiguo, viniloDeCharly, carneDeLosBeatles, llaveMaestra) y acompañantes (sinAcompaniante, acompanianteTRex)
class Item {
  const property nombre
  method usarEn(piso, protagonista){
    piso.usarItem(self, protagonista)
  }
}

const libroAntiguo = new Item(nombre = "El Libro antiguo")
const bajoDePedroAznar = new Item(nombre = "El bajode Pedro Aznar")
const carneDeLosBeattles = new Item(nombre = " El churrasco de los Beattles")
const llaveMaestra = new Item(nombre = "La Llave Maestra")
const manosVacias = new Item(nombre = "Manos Vacias")

