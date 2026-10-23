import src.pisos.*
// Objeto ascensor y estados de navegación (navegacionPrologo, navegacionLibre)
object ascensor {
  var property pisoActual = piso6_Oficina
  var property navegacion = navegacionPrologo
}

object navegacionPrologo {
    method nombre() = "Navegacion Prologo" 
  //method viajarA(numeroPiso, ascensor) = 
}

object navegacionLibre {
    method nombre() = "Navegacion Libre"
  //method viajarA(numeroPiso, ascensor) = 
}