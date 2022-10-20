import wollok.game.*
import elementosVisibles.*
import teclado.*



object titulo inherits ElementoVisible(image = "presentacion3.png", position = game.at(4, game.height()).down(6)) {

}

object instrucciones inherits ElementoVisible(image = "instru.png", position = game.at(2, game.height()).down(12)) {

}

object start inherits ElementoVisible(image = "start.png", position = game.at(6, game.height()).down(8)) {

}

object exit inherits ElementoVisible(image = "exit.png", position = start.position().down(1)) {

}


class Menu {

	method agregarOpciones()

	method iniciar() {
		self.agregarOpciones()
	}

}

object menuInicial inherits Menu {


	override method agregarOpciones() {
		game.addVisual(titulo)
		game.addVisual(start)
		game.addVisual(exit)
		
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuInicial()
	}
}

object pantallaInstrucciones{
	const anchoTotal = 17
    const altoTotal = 13
    method iniciar(){
        game.clear()
        game.title("aventuras carpincho")
        game.width(anchoTotal)
        game.height(altoTotal)
        game.addVisual(instrucciones)
        game.addVisual(start)
        teclado.configurarTeclasMenuInstrucciones()
        
	
}


}


