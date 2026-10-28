/* Personajes de cada piso y sus respuestas polimórficas a las 3 opciones de diálogo 
    Interactuar : Protagonista -> Personaje
    Responder : Personaje -> Protagonista
*/

// class Personaje {
//     var nombre
//     var property posicion
//     var property imagen
//     var entregoItem = false

//     method nombre() = nombre

//     method interactuar ()
//     method responder(opcion)
//     method recibirItem()
// }

import wollok.game.*

object charlyGarcia{
    method nombre() = "Charly Garcia"

    var property posicion = game.at(1,1)
    var property imagen = "charly.png"
    var yaDioBajo = false

    method interactuar(){
        if(yaDioBajo){
            game.say(self, "...")
        }else{
            game.say(self,"...")
        }
    }

    method responder(opcion){
        if(yaDioBajo){
            game.say(self, "...")
        }else{
            game.say(self, "...")
        }
    }

    method recibir(item, protagonista){}
}

object beatles{
    method nombre() = "Beatles"

    var property posicion = game.at(1,1)
    var property imagen = "beatles.png"
    var yaDioCarne = false

     method interactuar(){
        if(yaDioCarne){
            
        }else{
            game.say(self,"...")
        }
    }

    method responder(opcion){
        if(yaDioCarne){
            game.say(self, "...")
        }else{
            game.say(self, "...")
        }
    }
    method recibir(item, protagonista){}
}

object bibliotecario{

    var property posicion = game.at(1,1)
    var property imagen = "bibliotecario.png"
    var yaDioLibro = false

    method nombre() = "Bibliotecario"

    method interactuar(){
        if(yaDioLibro){
            game.say(self, "...")
        }else{
            game.say(self, "...")
        }
        
    }

    method responder(opcion){
        if(yaDioLibro){
            game.say(self, "...")
        }else{
            game.say(self, "...")
        }
        
    }

    method recibir(item, protagonista){}
}

object enteOscuro {

    var property posicion = game.at(1,1)
    var property imagen = "enteOscuro.png"

    method nombre() = "Ente oscuro"

    method interactuar(){}

    method responder(opcion){}

    method recibir(item, protagonista){}
}

object sinPersonaje {
    method nombre() = "nadie"
    method interactuar() {}
    method responder(opcion){}
    method recibir(item, protagonista){
        protagonista.decir("No sirve de nada usar " + item.nombre() + " en este piso.")
    }
}
//Acompaniantes
object tRex {
  method nombre() = "tRex"

  method comerCarne() {}

  method puedeAtacar() {}
} 

object sinAcompaniante {
  method nombre() = "Sin Acompañante"
} 

