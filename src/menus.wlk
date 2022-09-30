import wollok.game.*
import elementosVisibles.*
import teclado.*



object title inherits ElementoVisible(image = "presentacion.png", position = game.at(3, game.height()).down(9)) {

}

object start inherits ElementoVisible(image = "start.png", position = game.at(6, game.height()).down(11)) {

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
		title.mostrar()
		start.mostrar()
		exit.mostrar()
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuInicial()
	}


}

object menuInstruccionesTeclas inherits Menu {

	override method agregarOpciones() {
		start.mostrar()
	}


}



