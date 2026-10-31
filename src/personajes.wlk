/* Personajes de cada piso y sus respuestas polimórficas a las 3 opciones de diálogo*/
import items.*
import pisos.*
import protagonista.*
import wollok.game.*
import juego.*

class Personaje {
     const property nombre
     var entregoItem = false
     const property retrato = "cara_default.png" // Imagen de la carita del personaje

     // Comportamientos por defecto (cada personaje sobreescribe lo que necesita)
  method respuestaAyudarAlPersonaje(unProtagonista) {
    unProtagonista.decir(nombre + ": No necesito ayuda con nada ahora mismo.")
  }

  method respuestaAcompaniar(unProtagonista) {
    unProtagonista.decir(nombre + ": Ni loco me subo a ese ascensor con olor a pata, tengo cosas que hacer acá.")
  }

  method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir(nombre + ": No tengo idea de que me estás hablando, escapar de donde?.")
  }

  method recibir(item, unProtagonista) {
    unProtagonista.decir(nombre + ": ¿Para qué quiero " + item.nombre() + "? No gracias, quedatelo.")
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

object bibliotecario inherits Personaje(nombre = "Bibliotecario") {
  var yaDioLibro = false

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    unProtagonista.decir("Bibliotecario: Shhh... solo necesito silencio para ordenar estos tomos antiguos, no hagas ruido.")
  }

  override method respuestaComoEscapar(unProtagonista) {
    if (not yaDioLibro) {
      yaDioLibro = true
      unProtagonista.tomarItem(libroAntiguo)
      unProtagonista.decir("Bibliotecario: Hace un rato pasó un tipo encapuchado y me dejó este libro, me dijo que se lo dé al proximo que se baje del ascensor asi que tomá.")
    } else {
      unProtagonista.decir("Bibliotecario: Ya te di el Libro Antiguo, yo lo revisé y parecia tener un mapa del tesoro dibujado pero no sé donde es.")
    }
  }
}

object charlyGarcia inherits Personaje(nombre = "Charly García") {
  var yaDioBajo = false

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    if (not yaDioBajo) {
      unProtagonista.modo(modoMinijuego)
      unProtagonista.decir("Charly: ¡Me olvidé Seminare! Quiero ver, quiero entrar, nena nadie te va a hacer... [1] ...mal, excepto amarte | [2] ...llorar hoy | [3] ...daño jamás")
    } else {
      unProtagonista.decir("Charly: ¡Gracias por hacerme acordar la letra, loco! Say No More, ahora tomate el palo que sigue el recital.")
    }
  }

  override method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir("Charly: Para salir de acá necesitás rock. Ayudame con este tema y vemos con que te ayudo loco.")
  }

  override method verificarLetra(opcion, unProtagonista) {
    if (opcion == 1) {
      yaDioBajo = true
      unProtagonista.tomarItem(bajoDePedroAznar)
      unProtagonista.decir("Charly: ¡Esa es la letra! Tomá el Bajo de Pedro Aznar como agradecimiento.")
    } else {
      unProtagonista.decir("Charly: ¡Cualquiera mandaste! Así no sigue el tema. Volvé a hablarme cuando te la acuerdes.")
    }
  }
}

object beatles inherits Personaje(nombre = "Los Beatles") {
  var yaDioCarne = false

  override method respuestaAyudarAlPersonaje(unProtagonista) {
    if (not yaDioCarne) {
      unProtagonista.decir("Paul McCartney: Perdí mi bajo y no podemos tocar en la carnicería. Si nos traés un buen bajo, te puedo ofrecer nuestro mejor corte de carne.")
    } else {
      unProtagonista.decir("John Lennon: ¡Este bajo que nos diste suena increíble! Espero que te sirva el churrasco que te dimos, es lo mejor de lo mejor.")
    }
  }

  override method respuestaComoEscapar(unProtagonista) {
    unProtagonista.decir("Ringo Starr: Escapar? Yo entiendo que La Matanza no es como Liverpool, pero acá vendemos la mejor carne para alimentar al barrio.")
  }

  override method recibir(item, unProtagonista) {
    if (item == bajoDePedroAznar and not yaDioCarne) {
      yaDioCarne = true
      unProtagonista.reemplazarItem(bajoDePedroAznar, carneDeLosBeattles)
      unProtagonista.decir("Paul McCartney: Este bajo está TREMENDO! Como te prometí acá tenes un corte de nuesra mejor carne, que la disfrutes!.")
    } else {
      super(item, unProtagonista)
    }
  }
}

// El T-Rex actúa como personaje en la jungla y luego como acompañante del protagonista
object tRex inherits Personaje(nombre = "T-Rex") {
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