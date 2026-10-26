import protagonista.*
import items.*
import personajes.*

// Clase Piso y objetos para cada uno de los pisos dimensionales
class Piso {
  var property numero 
  const descripcion
  var property personaje = sinPersonaje

  method inspeccionar() = descripcion

  method hablarConPersonaje(opcion, unProtagonista) {
    personaje.responder(opcion, unProtagonista)
  }

  method responderMinijuego(opcion, unProtagonista) {
    personaje.verificarLetra(opcion, unProtagonista)
  }

  method usarItem(item, unProtagonista) {
    unProtagonista.decir("No sirve de nada usar " + item.nombre() + " en este piso.")
  }

  method recibirAcompaniante(acompaniante, unProtagonista) {
    if (acompaniante.puedeAtacar()) {
      unProtagonista.decir("El T-Rex ruge al pedo, no hay nadie a quien asustar.")
    } else {
      unProtagonista.decir("Estoy solo, no tengo ningún acompañante para mandar.")
    }
  }
}


object piso0_PlantaBaja inherits Piso(
  numero = 0,
  descripcion = "La puerta de salida está cerrada con cadenas y candado, además hay un tipo encapuchado con muy mal olor.",
  personaje = enteOscuro
) {
  override method usarItem(item, unProtagonista) {
    if (item == llaveMaestra) {
      unProtagonista.soltarItem(llaveMaestra)
      unProtagonista.decir("Ente Oscuro: 'Has cumplido...' ¡El ente abre el candado, te deja salir y ganaste el juego!")
    } else {
      super(item, unProtagonista)
    }
  }
} 
  //Interacción con un personaje que le indique que debe encontrar la llave mágica escondida en el edificio
  //para poder salir

object piso1_Biblioteca inherits Piso(
  numero = 1,
  descripcion = "Hay libros antiguos y mucha arena en el horizonte.",
  personaje = bibliotecario
) {}
  //Hay un bibliotecario, le presenta un libro al protagonista que tiene un mapa
  // que le dice donde esta la llave escondida en la base militar.

object piso2_RecitalCharly inherits Piso(
  numero = 2,
  descripcion = "Recital de Charly: Lluvia torrencial y teclados en peligro.",
  personaje = charlyGarcia
) {}
  //Charly García está en un recital, y se olvida la letra de Seminare, el jugador debe completarla.
  //Al finalizarla, Charly le da un Bajo al protagonista en agradencimiento

object piso3_CarniceriaBeatles inherits Piso(
  numero = 3,
  descripcion = "Carnicería de Los Beatles: Asado al ritmo de Abbey Road.",
  personaje = beatles
) {
  override method recibirReliquiaRock(unProtagonista) {
    unProtagonista.soltarItem(bajo)
    unProtagonista.agarrarItem(carneDeLosBeattles)
    unProtagonista.decir("Paul McCartney: ¡Qué joya! Tomá nuestro mejor corte de carne a cambio.")
  }
}

  //Los Beatles tienen una carnicería. A Paul Mccartney le falta el bajo. 
  // Al completar el nivel, le dan al personaje un pedazo de carne.

object piso4_JunglaPrehistorica inherits Piso(
  numero = 4,
  descripcion = "Esta jungla esta llena de arboles gigantes... y hay un re bicho que gruñe y me mira entre los arboles.",
  personaje = tRex
) 
{
  override method recibirCarne(unProtagonista) {
    unProtagonista.soltarItem(carneDeLosBeattles)
    tRex.comerCarne()
    unProtagonista.decir("¡El T-Rex se comió el churrasco y ahora me pide mimos. Un tierno... capaz me quiere acompañar")
  }
}
  //Hay un tiranosaurio Rex. Para que no ataque hay que alimentarlo (pedazo de carne).
  //Al completarlo, el Trex es acompañante del protagonista

object piso5_BaseMilitar inherits Piso(
  numero = 5,
  descripcion = "Es una base militar custodiada por milicos, parece el area 51...",
  personaje = sinPersonaje
) {
  var property estaDespejada = false

  override method ataqueDeTRex(unProtagonista) {
    if (not estaDespejada) {
      estaDespejada = true
      unProtagonista.decir("¡El T-Rex corrió a todos los militares y dejó la base libre! Ahora puedo usar el mapa para buscar la llave.")
    } else {
      unProtagonista.decir("La base ya está completamente despejada.")
    }
  }

  override method recibirMapa(unProtagonista) {
    if (estaDespejada) {
      unProtagonista.soltarItem(libroAntiguo)
      unProtagonista.agarrarItem(llaveMaestra)
      unProtagonista.decir("¡Guiándote con el mapa encontraste el lugar exacto y desenterraste la Llave Maestra!")
    } else {
      unProtagonista.decir("¡Imposible ponerse a buscar con el mapa mientras los militares vigilan! Me van a dejar con más agujeros que un queso!.")
    }
  }
}


//Base Militar peligrosa, el personaje no puede pasar sin ayuda del TRex. La llave se encuentra escondida en la base.
// El personaje necesita el mapa para encontrar la llave. 

object piso6_Oficina inherits Piso(
  numero = 6,
  descripcion = "Terminó la jornada laboral, quiero irme a casa."
) {}

  //En este piso arranca el juego. El personaje se quiere ir a su casa y se sube al ascensor
