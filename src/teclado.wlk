import wollok.game.*
import tablero.*
import menus.*

object teclado {

	method configurarTeclasMenuInicial() {
		// Tecla Mostrar Keys Configuradas Por Jugador
		keyboard.space().onPressDo({ tablero.setearMenuInstruccionesTeclas()})

		// Tecla Finalizar Juego
		keyboard.control().onPressDo({ tablero.finalizarJuego()})
	}

	method configurarTeclasMenuFinal() {
		// Tecla Menu Inicial
		keyboard.space().onPressDo({ tablero.setearMenuInicial()})
		// Tecla Finalizar Juego
		keyboard.alt().onPressDo({ tablero.finalizarJuego()})
	}

	

}

