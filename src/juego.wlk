import wollok.game.*

object juego {
  method iniciar() {
    game.title("Ascensor Dimensional")
    game.width(15)
    game.height(10)
    game.cellSize(64)
    
    game.start()
  }
}