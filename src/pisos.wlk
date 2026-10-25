import src.protagonista.*
// Clase Piso y objetos para cada uno de los pisos dimensionales
class Piso {
  var property numero 
  var descripcion
  //var persojane

  //method imagen()
  //method inspeccionar()
  //method usarItem(item, protagonista)
  //method recibirAcompaniante(acompaniante, protagonista)
}


  
const piso0_PlantaBaja = new Piso(
  numero = 0,
  descripcion = "Planta Baja: La puerta de salida está cerrada con cadenas y candado.")
  //Interacción con un personaje que le indique que debe encontrar la llave mágica escondida en el edificio
  //para poder salir

const piso1_Biblioteca = new Piso(
  numero = 1,
  descripcion = "Biblioteca de Alejandría: Hay libros antiguos y humo en el horizonte.") 

  //Hay un bibliotecario, le presenta un libro al protagonista que tiene un mapa
  // que le dice donde esta la llave escondida en la base militar.

const piso2_RecitalCharly = new Piso(
  numero = 2,
  descripcion = "Recital de Charly: Lluvia torrencial y teclados en peligro.")
  //Charly García está en un recital, y se olvida la letra de Seminare, el jugador debe completarla.
  //Al finalizarla, Charly le da un Bajo al protagonista en agradencimiento

const piso3_CarniceriaBeatles = new Piso(
  numero = 3,
  descripcion = "Carnicería de Los Beatles: Asado al ritmo de Abbey Road.")

  //Los Beatles tienen una carnicería. A Paul Mccartney le falta el bajo. 
  // Al completar el nivel, le dan al personaje un pedazo de carne.

const piso4_JunglaPrehistorica = new Piso(
  numero = 4,
  descripcion = "Jungla Prehistórica: Árboles gigantes y un T-Rex hambriento.")

  //Hay un tiranosaurio Rex. Para que no ataque hay que alimentarlo (pedazo de carne).
  //Al completarlo, el Trex es acompañante del protagonista

const piso5_BaseMilitar = new Piso(
  numero = 5,
  descripcion = "Base Militar: Zona custodiada con armas de alto calibre.")


//Base Militar peligrosa, el personaje no puede pasar sin ayuda del TRex. La llave se encuentra escondida en la base.
// El personaje necesita el mapa para encontrar la llave. 

const piso6_Oficina = new Piso(
  numero = 6,
  descripcion = "Oficina: Terminó la jornada laboral, querés ir a casa.")

  //En este piso arranca el juego. El personaje se quiere ir a su casa y se sube al ascensor
