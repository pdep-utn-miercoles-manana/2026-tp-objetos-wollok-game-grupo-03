/* Personajes de cada piso y sus respuestas polimórficas a las 3 opciones de diálogo*/
import items.*
import pisos.*
import protagonista.*
import wollok.game.*
import juego.*

class Personaje {
     const property nombre
     var property entregoItem = false
     const property retrato

     // Comportamientos por defecto (cada personaje sobreescribe lo que necesita)
  method respuestaAyudarAlPersonaje(unProtagonista) {
    unProtagonista.decir(self, nombre + ": No necesito ayuda con nada ahora mismo.")
  }

  method respuestaAcompaniar(unProtagonista) {
    unProtagonista.decir(self, nombre + ": Ni loco me subo a ese ascensor con olor a pata, tengo cosas que hacer acá.")
  }

  method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir(self,nombre + ": No tengo idea de que me estás hablando, escapar de donde?.")
  }

  method recibir(item, unProtagonista) {
    unProtagonista.decir(self, nombre + ": ¿Para qué quiero " + item.nombre() + "? No gracias, quedatelo.")
  }

  method verificarLetra(opcion, unProtagonista) {} // Solo par Charly

  // Método plantilla que delega en las 3 opciones de diálogo
  method responder(opcion, unProtagonista) {
    if (opcion == 1) {
      self.respuestaAyudarAlPersonaje(unProtagonista)
    } else if (opcion == 2) {
      self.respuestaAcompaniar(unProtagonista)
    } else if (opcion == 3) {
      self.respuestaComoEscapar(unProtagonista)
    }
  }

}

// Personajes de cada piso (del 0 al 6)

object enteOscuro inherits Personaje(nombre = "Ente Oscuro" , retrato = "cara_ente.png") {
  override method respuestaAyudarAlPersonaje(unProtagonista) {
    unProtagonista.conversar([
      new LineaDialogo(hablante = unProtagonista, texto = "Disculpá maestro... ¿necesitás una mano con algo?"),
      new LineaDialogo(hablante = self, texto = "Mi única misión es custodiar este candado dimensional..."),
      new LineaDialogo(hablante = self, texto = "Más que ayudarme a mí, preocupate vos por encontrar cómo salir."),
      new LineaDialogo(hablante = unProtagonista, texto = "alto mala onda...")
    ])
  }

  override method respuestaAcompaniar(unProtagonista) {
    unProtagonista.conversar([
      new LineaDialogo(hablante = unProtagonista, texto = "¿No querés subir al ascensor conmigo? Me da miedo ir solo."),
      new LineaDialogo(hablante = self, texto = "Ni loco me subo a esa trampa mortal. Yo no me muevo de esta puerta hasta ver la llave.")
    ])
  }

  override method respuestaComoEscapar(unProtagonista) {
    unProtagonista.conversar([
      new LineaDialogo(hablante = unProtagonista, texto = "¡Che, qué onda esas cadenas! Me quiero ir a mi casa, ¿cómo hago para salir?"),
      new LineaDialogo(hablante = self, texto = "Jajaja... ya no estás en Sancor Seguros, gil."),
      new LineaDialogo(hablante = self, texto = "Para que te abra este candado vas a tener que hacerme un favor..."),
      new LineaDialogo(hablante = self, texto = "...Vas a tener que traerme la Llave Maestra..."),
      new LineaDialogo(hablante = unProtagonista, texto = " ¿¡Una llave maestra!? ¿Y de dónde saco eso?"),
      new LineaDialogo(hablante = self, texto = "Está enterrada en alguno de los pisos de ese ascensor."),
      new LineaDialogo(hablante = self, texto = "Como la vas a encontrar? Ni idea, vos fijate, buscate un mapa o algo."),
      new LineaDialogo(hablante = self, texto = "Pero para poder salir vas a tener que traerme esa llave y te dejo libre.")
    ])
  }

  override method recibir(item, unProtagonista) {
    if (item == llaveMaestra) {
      unProtagonista.quitarItem(llaveMaestra)
      unProtagonista.modo(modoFinDelJuego)
      unProtagonista.decir("LO LOGRÉ! POR FIN PUEDO VOLVER A CASA!!!")
    } else {
      unProtagonista.decir("Eso no abre este candado ni tiene forma de llave wachin. Traeme la Llave Maestra.")
    }
  }
}

object bibliotecario inherits Personaje(nombre = "Bibliotecario", entregoItem = false, retrato = "cara_bibliotecario.png") {

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    unProtagonista.decir(self, "Shhh... necesito silencio para ordenar estos tomos antiguos, no hagas mucho ruido por favor.")
  }

  override method respuestaComoEscapar(unProtagonista) {
    if (not entregoItem) {
      entregoItem = true
      unProtagonista.tomarItem(libroAntiguo)
      unProtagonista.conversar([
      new LineaDialogo(hablante = unProtagonista, texto = "Perdoname, estoy buscando algo llamado La Llave maestra, sabes donde puede estar?"),
      new LineaDialogo(hablante = self, texto = "La llave maestra? Ese es un artefacto que pertenece a un mito muy antiguo..."),
      new LineaDialogo(hablante = self, texto = "Dicen que permite viajar a otros mundos paralelos al que nosotros coexistimos."),
      new LineaDialogo(hablante = self, texto = "Si querés te puedo conseguir un libro del mito y puedas encontrarlo"),
      new LineaDialogo(hablante = unProtagonista, texto = "¿¡EN SERIO?! Sos un crack, idolo, maquina, fiera, un campeón."),
      new LineaDialogo(hablante = self, texto = "Bueno, acá lo tenés, buena suerte con tu busqueda viajero."),
      new LineaDialogo(hablante = unProtagonista, texto = "Muchisimas gracias, ahora le voy a pegar una leída a ver que dice"),
      new LineaDialogo(hablante = unProtagonista, texto = "... (leyendo muy atentamente)"),
      new LineaDialogo(hablante = unProtagonista, texto = "Ok.. según este mapa y el texto, la llave se encuentra enterrada en un área llamada..."),
      new LineaDialogo(hablante = unProtagonista, texto = "AREA 51? Estoy hasta las manos...")
    ])
    } else {
      unProtagonista.decir(self, "Ya te di el Libro Antiguo del que hablamos, quizas el mapa que incluye pueda ayudarte a encontrar la llave.")
    }
  }

   override method respuestaAcompaniar(unProtagonista) {
      unProtagonista.conversar([
      new LineaDialogo(hablante = unProtagonista, texto = "No queres acompañarme a buscar la llave? 2 cabezas piensan y buscan mejor que una."),
      new LineaDialogo(hablante = self, texto = "Mil disculpas, pero estoy atrasado con estos libros y debo ordenarlos si o si."),
      new LineaDialogo(hablante = self, texto = "Igualmente, suerte con tu busqueda!")
      ])
  }
}

object charlyGarcia inherits Personaje(nombre = "Charly García", entregoItem = false, retrato = "cara_charly.png") {

  var etapaCancion = 1

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    if (not entregoItem) {
      etapaCancion = 1
      unProtagonista.modo(modoMinijuego)
      cajaDeTexto.mostrarLineasMinijuego([
        new LineaDialogo(hablante = unProtagonista, texto = "CHARLY! QUERIDO! Necesitas que te ayude con algo?"),
        new LineaDialogo(hablante = self, texto = "Que haces loco, ¡Me olvidé Seminare! Ayudame a seguirla!"),
        new LineaDialogo(hablante = self, texto = "'Quiero ver, quiero entrar, nena nadie...'"),
        new LineaDialogo(hablante = self, texto = "[1] te va a hacer mal, excepto amarte | [2] ... te ha besado hoy | [3] ... te daño jamás")
      ])
    } else {
      unProtagonista.decir(self, "¡Gracias por hacerme acordar la letra loco! Say No More, ahora tomate el palo que sigue el recital.")
    }
  }

  override method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir(self, "Escaparte de mi recital? Si no te gusta mi musica tomate el palo y punto, pancho.")
  }

  override method respuestaAcompaniar(unProtagonista) {
      unProtagonista.decir(self, "Yo no te acompaño a ningún lado, no vesa que estoy tocando gil.")
  }

override method verificarLetra(opcion, unProtagonista) {
    if (etapaCancion == 1) {
      if (opcion == 1) {
        etapaCancion = 2
        unProtagonista.modo(modoMinijuego)
        cajaDeTexto.mostrarLineasMinijuego([
          new LineaDialogo(hablante = self, texto = "¡Bien ahí! Te la sabés ¿Y cómo sigue?"),
          new LineaDialogo(hablante = self, texto = "Vas aquí, vas allá. Pero nunca te encontrarás.."),
          new LineaDialogo(hablante = self, texto = "[1] ...a vos mismo | [2] ...al escaparte | [3] ...con Batman")
        ])
      } else {
        self.fallarCancion(unProtagonista)
      }
    } else if (etapaCancion == 2) {
      if (opcion == 2) {
        etapaCancion = 3
        unProtagonista.modo(modoMinijuego)
        cajaDeTexto.mostrarLineasMinijuego([
          new LineaDialogo(hablante = self, texto = "¡Vamos todavía! Ya casi estamos loco, vamos con la última"),
          new LineaDialogo(hablante = self, texto = "Te doy pan, quieres sal. Nena nunca te voy a dar..."),
          new LineaDialogo(hablante = self, texto = "[1] ...un choripán | [2] ...pimienta | [3] ...lo que me pides")
        ])
      } else {
        self.fallarCancion(unProtagonista)
      }
    } else if (etapaCancion == 3) {
      if (opcion == 3) {
        entregoItem = true
        unProtagonista.tomarItem(bajoDePedroAznar)
        cajaDeTexto.mostrarLineasMinijuego([
          new LineaDialogo(hablante = self, texto = "Que temazo! Me salvaste el recital loco, tomá te doy el bajo de Pedro Aznar como agradecimiento"),
          new LineaDialogo(hablante = self, texto = "Sabes tocar el bajo?"),
          new LineaDialogo(hablante = unProtagonista, texto = "No..."),
          new LineaDialogo(hablante = self, texto = "Bueno no importa, algún uso le vas a encontrar. Chau loco, gracias.")
        ])
      } else {
        self.fallarCancion(unProtagonista)
      }
    }
  }

  method fallarCancion(unProtagonista) {
    etapaCancion = 1
    unProtagonista.decir(self, "¡Tiraste cualquiera! Así no sigue el tema. Volvé a hablarme cuando te aprendas mis canciones cipayo.")
  }
}

object beatles inherits Personaje(nombre = "Los Beatles", entregoItem = false, retrato = "cara_beatles.png") {

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    if (not entregoItem) {
      unProtagonista.decir("Paul McCartney: Perdí mi bajo y no podemos tocar en la carnicería. Si nos traés un buen bajo, te puedo ofrecer nuestro mejor corte de carne.")
    } else {
      unProtagonista.decir("John Lennon: ¡Este bajo que nos diste suena increíble! Espero que te sirva el churrasco que te dimos, es lo mejor de lo mejor.")
    }
  }

  override method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir("Ringo Starr: Escapar? Yo entiendo que La Matanza no es como Liverpool, pero acá vendemos la mejor carne para alimentar al barrio.")
  }

  override method recibir(item, unProtagonista) {
    if (item == bajoDePedroAznar and not entregoItem) {
      entregoItem = true
      unProtagonista.reemplazarItem(bajoDePedroAznar, carneDeLosBeattles)
      piso3_CarniceriaBeatles.actualizarImagenConBajo()
      unProtagonista.decir("Paul McCartney: Este bajo está TREMENDO! Como te prometí acá tenes un corte de nuesra mejor carne, que la disfrutes!.")
    } else {
      super(item, unProtagonista)
    }
  }
}

// El T-Rex actúa como personaje en la jungla y luego como acompañante del protagonista
object tRex inherits Personaje(nombre = "T-Rex", retrato = "cara_TRex.png") {
  var comioCarne = false

  method comerCarne() {
    comioCarne = true
  }

  method puedeAtacar() = true

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    if (not comioCarne) {
      unProtagonista.decir("¡ROAAAR! (Le suena la panza de una forma espantosa. Claramente está cagado de hambre).")
    } else {
      unProtagonista.decir("El T-Rex está con la panza llena y mueve la cola como un perrito, es un tierno.")
    }
  }

  override method respuestaAcompaniar(unProtagonista) {
    if (not comioCarne) {
      unProtagonista.decir("¡GRRRR! (Ni loco lo meto al ascensor con este hambre, me va a morfar de un mordisco).")
    } else {
      unProtagonista.acompaniante(self)
      piso4_JunglaPrehistorica.seFueElTRex()
      unProtagonista.decir("¡El T-Rex se subió al ascensor! Ahora podés apretar [A] en cualquier piso para mandarlo al ataque.")
    }
  }

  override method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir("¡ROAAAR! (Es un dinosaurio, de candados y llaves mucho no entiende).")
  }

  override method recibir(item, unProtagonista) {
    if (item == carneDeLosBeattles and not comioCarne) {
      unProtagonista.quitarItem(carneDeLosBeattles)
      self.comerCarne()
      piso4_JunglaPrehistorica.tRexAlimentado()
      unProtagonista.decir("¡El T-Rex se comió el churrasco y ahora pide mimos! Capaz me acompañe a otros pisos con este buen humor.")
    } else {
      unProtagonista.decir("El T-Rex olfatea " + item.nombre() + " y lo rechaza. Quiere carne de verdad.")
    }
  }
}



// --- OBJETOS NULOS POLIMÓRFICOS ---

object sinPersonaje {
  method nombre() = "nadie"
  method responder(opcion, unProtagonista) {
    unProtagonista.decir("No hay nadie con quien hablar en este piso. Estoy hablando solo, estoy re chapita.")
  }
  method recibir(item, unProtagonista) {
    unProtagonista.decir("No sirve de nada usar " + item.nombre() + " en este piso.")
  }
  method verificarLetra(opcion, unProtagonista) {}
}

object sinAcompaniante {
  method nombre() = "Sin Acompañante"
  method puedeAtacar() = false
}