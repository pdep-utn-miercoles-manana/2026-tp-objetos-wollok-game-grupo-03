import protagonista.*
import items.*
import personajes.*
import juego.*


// Clase Piso y objetos para cada uno de los pisos dimensionales
class Piso {
  var property numero 
  var property descripcion
  var property personaje
  var property imagen = "piso6_oficina.png" // Imagen por defecto

  // Para describir el piso
  method inspeccionar() = descripcion

  // Intermediario en las charlas 
  method hablarConPersonaje(opcion, unProtagonista) {
    personaje.responder(opcion, unProtagonista)
  }

  method responderMinijuego(opcion, unProtagonista) {
    personaje.verificarLetra(opcion, unProtagonista)
  }

  // Intermediario entre los items y los pisos
  method usarItem(item, unProtagonista) {
    personaje.recibir(item, unProtagonista)
  }

  // Intermediario para el acompañante
  method recibirAcompaniante(acompañante, unProtagonista) {
    if (acompañante.puedeAtacar()) {
      unProtagonista.decir("El T-Rex ruge al pedo, no hay nadie a quien asustar.")
    } else {
      unProtagonista.decir("Estoy solo, no tengo ningún acompañante para mandar.")
    }
  }

  //para pistas de audio: 
  method entrar() {}
  method salir() {}
}


object piso0_PlantaBaja inherits Piso(
  numero = 0,
  descripcion = "La puerta de salida está cerrada con cadenas y candado, además hay un tipo encapuchado con un horrible olor a humedad.",
  personaje = enteOscuro,
  imagen = "piso0_entrada.png"
) {
  const ambienteOscuro = game.sound("audioOscuro.mp3")

  override method entrar() {
    ambienteOscuro.shouldLoop(true)
    ambienteOscuro.volume(0.2)
    ambienteOscuro.play()
  }

  override method salir() {
    if (ambienteOscuro.played()) {
      ambienteOscuro.stop()
    }
  }
}

object piso1_Biblioteca inherits Piso(
  numero = 1,
  descripcion = "Es una biblioteca llena de libros y papiros antiguos. Hay un egipcio muy fachero ordenando libros varios, capaz sepa como salir de acá.",
  personaje = bibliotecario,
  imagen = "piso1_biblioteca.png"
) {
  const ambienteBiblioteca = game.sound("biblioteca.mp3")

  override method entrar() {
    ambienteBiblioteca.shouldLoop(true)
    ambienteBiblioteca.volume(0.2)
    ambienteBiblioteca.play()
  }

  override method salir() {
    if (ambienteBiblioteca.played()) {
      ambienteBiblioteca.stop()
    }
  }
}
  //Hay un bibliotecario, le presenta un libro al protagonista que tiene un mapa
  // que le dice donde esta la llave escondida en la base militar.

object piso2_RecitalCharly inherits Piso(
  numero = 2,
  descripcion = "NO TE PUEDO CREER CHARLY GARCÍA Y CANTANDO SEMINARE... es el mejor dia de mi vida",
  personaje = charlyGarcia,
  imagen = "piso2_seminare.png"
) {
  const ambiente = game.sound("recital_charly.mp3")
  const seminare = game.sound("seminare.mp3")

  override method entrar() {
    self.reproducirAmbiente()
  }

  override method salir() {
    self.frenarTodo()
  }

  method reproducirAmbiente() {
    self.frenarTodo()
    ambiente.shouldLoop(true)
    ambiente.volume(0.1)
    ambiente.play()
  }

  method reproducirSeminare() {
    self.frenarTodo()
    seminare.shouldLoop(true)
    seminare.volume(0.6)
    seminare.play()
  }

  method frenarTodo() {
    if (ambiente.played()) { ambiente.stop() }
    if (seminare.played()) { seminare.stop() }
  }
}
  //Charly García está en un recital, y se olvida la letra de Seminare, el jugador debe completarla.
  //Al finalizarla, Charly le da un Bajo al protagonista en agradencimiento

object piso3_CarniceriaBeatles inherits Piso(
  numero = 3,
  descripcion = "Parece que a los beatles no les funcionó el curro de la música y se pusieron una carnicería... tremendo.",
  personaje = beatles,
  imagen = "piso3_obladioblada.png"
) {
  // Agregamos este método para que los Beatles le avisen al piso
  method actualizarImagenConBajo() {
    imagen = "piso3_beatlesConBajo.png"
    visorDePantalla.mostrarPisoActual() // Refresca la pantalla al instante
  }

  const ambienteCarniceria = game.sound("carniceria.mp3")

  override method entrar() {
    ambienteCarniceria.shouldLoop(true)
    ambienteCarniceria.volume(0.2)
    ambienteCarniceria.play()
  }

  override method salir() {
    if (ambienteCarniceria.played()) {
      ambienteCarniceria.stop()
    }
}
}

  //Los Beatles tienen una carnicería. A Paul Mccartney le falta el bajo. 
  // Al completar el nivel, le dan al personaje un pedazo de carne.

object piso4_JunglaPrehistorica inherits Piso(
  numero = 4,
  descripcion = "Esta jungla esta llena de arboles gigantes... y hay un re bicho que gruñe y me mira entre los arboles.",
  personaje = tRex,
  imagen = "piso4_rawr.png"
) 
{
  const ambienteJungla = game.sound("jungla.mp3")

  method tRexAlimentado() {
    descripcion = "El T-Rex se comió el churrasco y ahora tiene cara de bueno. Parece un perrito gigante."
    imagen = "piso4_feliz.png" // 2. Estado intermedio: T-Rex amigable
    visorDePantalla.mostrarPisoActual() 
  }

  method seFueElTRex() {
    personaje = sinPersonaje
    descripcion = "La jungla prehistórica tiene un depredador menos, el T-Rex se viene conmigo a casa."
    imagen = "piso4_sinTRex.png" // 3. Estado final: Jungla vacía
    visorDePantalla.mostrarPisoActual() 
  }

  

  override method entrar() {
    ambienteJungla.shouldLoop(true)
    ambienteJungla.volume(0.4)
    ambienteJungla.play()
  }

  override method salir() {
    if (ambienteJungla.played()) {
      ambienteJungla.stop()
    }
  }
}
  //Hay un tiranosaurio Rex. Para que no ataque hay que alimentarlo (pedazo de carne).
  //Al completarlo, el Trex es acompañante del protagonista

object piso5_BaseMilitar inherits Piso(
  numero = 5,
  descripcion = "Es una base militar custodiada por muchisimos milicos, parece el area 51...",
  personaje = sinPersonaje,
  imagen = "piso5_shadowMoses.png"
) {
  const ambienteMilitar = game.sound("baseMilitar.mp3")
  const sonidoAtaque = game.sound("momentoAtaque.mp3")
  const ambienteDespejado = game.sound("baseDespejada.mp3")
  var property estaDespejada = false

  override method entrar(){
    if(estaDespejada){
      ambienteDespejado.shouldLoop(true)
      ambienteDespejado.volume(0.4)
      ambienteDespejado.play()
    }else{
      ambienteMilitar.shouldLoop(true)
    ambienteMilitar.volume(0.3)
    ambienteMilitar.play()
    }
  }

  override method salir(){
    if(ambienteDespejado.played()){
      ambienteDespejado.stop()
    }
    if(ambienteMilitar.played()){
      ambienteMilitar.stop()
    }
  }

  //ataqueTrex -> recibirAcompaniante para hacer polimorfismo, consulta
  override method recibirAcompaniante(acompaniante, unProtagonista) {
    if (acompaniante.puedeAtacar()) {
      if (not estaDespejada) {
        estaDespejada = true

        if(ambienteMilitar.played()){
          ambienteMilitar.stop()
        }
        sonidoAtaque.volume(0.5)
        sonidoAtaque.play()
        ambienteDespejado.shouldLoop(true)
        ambienteDespejado.volume(0.4)
        ambienteDespejado.play()

        descripcion = "La base militar quedó completamente desierta tras el ataque del T-Rex. Ahora sería un buen momento para ver que onda este lugar sin que me disparen."
        imagen = "piso5_atacado.png" // <-- CAMBIA LA IMAGEN AL DESTRUIR
        visorDePantalla.mostrarPisoActual()
        unProtagonista.decir("¡El T-Rex corrió a todos los militares y dejó la base libre! Ahora puedo usar el mapa para buscar la llave.")
      } else {
        unProtagonista.decir("La base ya está completamente despejada, el T-Rex se los boleteó a todos")
      }
    } else {
        super(acompaniante, unProtagonista)
    }
  }
  //habria que usar usarItem(LibroAntiguo), consulta
  override method usarItem(item, unProtagonista) {
    if (item == libroAntiguo) {
      if(estaDespejada) {
        unProtagonista.reemplazarItem(item, llaveMaestra)
        descripcion = "La base militar quedó vacía y solo queda el pozo donde desenterré la Llave Maestra."
        unProtagonista.decir("ESTE MAPA ME SALVÓ LA VIDA!! Pude encontrar la llave maestra para poder escapar. Menos mal, ya me estaba agarrando noni")
      } else unProtagonista.decir("¡Imposible ponerme a buscar con el mapa ahora! Me van a dejar con más agujeros que un queso!.")
    } else super(item, unProtagonista) 
  }
}


//Base Militar peligrosa, el personaje no puede pasar sin ayuda del TRex. La llave se encuentra escondida en la base.
// El personaje necesita el mapa para encontrar la llave. 

object piso6_Oficina inherits Piso(
  numero = 6,
  descripcion = "Terminó la jornada laboral y no queda nadie en la oficina, quiero irme a casa.",
  personaje = sinPersonaje,
  imagen = "piso6_oficina.png"
) {
   var ambienteOficina = null

  override method entrar() {
    if (ambienteOficina == null) {
      ambienteOficina = game.sound("oficina.mp3")
      ambienteOficina.shouldLoop(true)
      ambienteOficina.volume(0.1)
    }
    ambienteOficina.play()
  }

  override method salir() {
    if (ambienteOficina.played()) {
      ambienteOficina.stop()
    }
  }
}
  //En este piso arranca el juego. El personaje se quiere ir a su casa y se sube al ascensor
