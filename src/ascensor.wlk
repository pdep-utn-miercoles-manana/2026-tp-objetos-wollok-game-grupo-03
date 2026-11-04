import pisos.*
import protagonista.*
import juego.*
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
    cajaDeTexto.ocultar()
    pisoActual.salir()
    visorDePantalla.mostrarAscensorCerrado()
    const sonidoPuertas = game.sound("abrirAscensor.mp3")
    sonidoPuertas.volume(0.3)
    sonidoPuertas.play()

    game.schedule(2000, {
    const destino = pisos.find({ p => p.numero() == numeroPiso })
    pisoActual = destino
    pisoActual.entrar()
    visorDePantalla.mostrarPisoActual()
    protagonista.modo(modoExploracion)
    protagonista.decir("Llegué al piso " + numeroPiso + ". " + "a ver que onda...")})
    
  }
}

  object navegacionPrologo {
    method viajarA(numeroPiso, unAscensor) {
      if (numeroPiso == 0) {
        unAscensor.navegacion(navegacionLibre)
        unAscensor.irAPiso(0)
        game.schedule(2100, {
        protagonista.decir("¿QUE PASO ACÁ? ¿Y LA SALIDA? Capaz ese tipo encapuchado me dice que pasó.")
      })
      } else {
        protagonista.decir("Estoy muy cansado para ir a otros pisos, mejor voy a la planta Baja .")
      }
    }
 }

// object navegacionLibre {
//   method viajarA(numeroPiso, unAscensor) {
//     unAscensor.irAPiso(numeroPiso)
//   }
// }

object navegacionLibre {
  method viajarA(numeroPiso, unAscensor) {
    if (unAscensor.pisoActual().numero() == numeroPiso) {
      protagonista.decir("Ya estoy en este piso.")
    } else {
      unAscensor.irAPiso(numeroPiso)
    }
  }
}
