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


  
object piso0_PlantaBaja inherits Piso(
  numero = 0,
  descripcion = "Planta Baja: La puerta de salida está cerrada con cadenas y candado."
) {}
object piso1_Biblioteca inherits Piso(
  numero = 1,
  descripcion = "Biblioteca de Alejandría: Hay libros antiguos y humo en el horizonte."
) {}
object piso2_RecitalCharly inherits Piso(
  numero = 2,
  descripcion = "Recital de Charly: Lluvia torrencial y teclados en peligro."
) {}
object piso3_CarniceriaBeatles inherits Piso(
  numero = 3,
  descripcion = "Carnicería de Los Beatles: Asado al ritmo de Abbey Road."
) {}
object piso4_JunglaPrehistorica inherits Piso(
  numero = 4,
  descripcion = "Jungla Prehistórica: Árboles gigantes y un T-Rex hambriento."
) {}
object piso5_BaseMilitar inherits Piso(
  numero = 5,
  descripcion = "Base Militar: Zona custodiada con armas de alto calibre."
) {}
object piso6_Oficina inherits Piso(
  numero = 6,
  descripcion = "Oficina: Terminó la jornada laboral, querés ir a casa."
) {}