import wollok.game.*
import tablero.*
import menus.*
import personajes.*

object teclado {

	method configurarTeclasMenuInicial() {
		// Tecla Mostrar Keys Configuradas Por Jugador
		keyboard.space().onPressDo({pantallaInstrucciones.iniciar()})
		
		// Tecla Finalizar Juego
		keyboard.control().onPressDo({ game.stop()})

	}
	
	method configurarTeclasMenuInstrucciones() {
		// Tecla Mostrar Keys Configuradas Por Jugador
		keyboard.space().onPressDo({juego.iniciar()})
		

	}
	


}

