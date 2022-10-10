import wollok.game.*
import tablero.*
import menus.*
import personajes.*

object teclado {

	method configurarTeclasMenuInicial() {
		// Tecla Mostrar Keys Configuradas Por Jugador
		keyboard.space().onPressDo({juego.iniciar()})

		// Tecla Finalizar Juego
		keyboard.control().onPressDo({ tablero.finalizarJuego()})
	}

	method configurarTeclasMenuFinal() {
		// Tecla Menu Inicial
		keyboard.space().onPressDo({juego.iniciar()})
		// Tecla Finalizar Juego
		keyboard.alt().onPressDo({ tablero.finalizarJuego()})
	}

	

}
