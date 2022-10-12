import wollok.game.*
import sonidos.*
import menus.*
import teclado.*
import personajes.*
object tablero {//s

	//const sonidoDeFondo = "sonido2.mp3"

	method setearFondo() {
		game.title("Aventuras carpinchescas")
		game.cellSize(70)
		game.width(17)
		game.height(16)
		game.ground("fondo_verde.jpg")
	}

	method limpiarTablero() {
		game.clear()
	}

	method setearMenuInicial() {
		self.limpiarTablero()
		menuInicial.iniciar()
		
	
	}

	method iniciar() {
		self.setearFondo()
		self.setearMenuInicial()
		//sonido.iniciar(sonidoDeFondo, true, 0)
	}

	method setearMenuInstruccionesTeclas() {
		self.limpiarTablero()
		menuInstruccionesTeclas.iniciar()
	}


	method finalizarJuego() {
		game.stop()
	}

}
