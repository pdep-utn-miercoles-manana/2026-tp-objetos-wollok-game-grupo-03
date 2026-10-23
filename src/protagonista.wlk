import items.*
// Objeto protagonista y modos de interacción (modoExploracion, modoDialogo, modoBotonera, etc.)
object protagonista {
    var property inventario = manosVacias
    var property acompaniante = sinAcompaniante
    //var property modo = modoBotonera 

    method soltarItem() {
        inventario = manosVacias
    }

}

