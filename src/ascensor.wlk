import pisos.*
import protagonista.*
// Objeto ascensor y estados de navegación (navegacionPrologo, navegacionLibre)
object ascensor {
  var property pisoActual = piso6_Oficina
  var property navegacion = navegacionPrologo
  
  const pisos = [
    piso0_PlantaBaja, piso1_Biblioteca, piso2_RecitalCharly, 
    piso3_CarniceriaBeatles, piso4_JunglaPrehistorica, 
    piso5_BaseMilitar, piso6_Oficina
  ]

  method botonPresionado(numeroPiso) {
    navegacion.viajarA(numeroPiso, self)
  }

  method irAPiso(numeroPiso) {
    const destino = pisos.find({ p => p.numero() == numeroPiso })
    pisoActual = destino
    // protagonista.decir("Llegué al piso " + numeroPiso + ". " + destino.inspeccionar())
  }
}

object navegacionPrologo {
    method nombre() = "Navegacion Prologo" 
  method viajarA(numeroPiso, unAscensor) {
    if (numeroPiso == 0) {
      unAscensor.irAPiso(0)
      unAscensor.navegacion(navegacionLibre)
      // protagonista.decir("¿QUE PASO ACÁ? ¿Y LA SALIDA? Capaz ese wacho encapuchado me dice que pasó.")
    } else {
      // protagonista.decir("Estoy muy cansado para ir a otros pisos, mejor voy a la planta Baja .")
    }
  }
}

object navegacionLibre {
    method nombre() = "Navegacion Libre"
  method viajarA(numeroPiso, unAscensor) {
    unAscensor.irAPiso(numeroPiso)
  }
}