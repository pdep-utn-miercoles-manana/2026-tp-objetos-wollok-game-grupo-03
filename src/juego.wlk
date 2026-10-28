import wollok.game.*
import protagonista.*

object juego {
  method iniciar() {
    game.title("Ascensor Dimensional")
    game.width(15)
    game.height(10)
    game.cellSize(64)
    
    // game.addVisual(protagonista) el personaje principal no tiene ni imagen ni posicion xq es en primera persona. 

    // Controles de acción
    keyboard.h().onPressDo({ protagonista.interactuar() })
    keyboard.i().onPressDo({ protagonista.teclaInspeccionar() })
    keyboard.e().onPressDo({ protagonista.usarEspacio(0)})
    keyboard.r().onPressDo({ protagonista.usarEspacio(1)})
    keyboard.a().onPressDo({ protagonista.teclaMandarAcompaniante()})
    keyboard.b().onPressDo({ protagonista.teclaBotonera()})

    // Teclas numéricas
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