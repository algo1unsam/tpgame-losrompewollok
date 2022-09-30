import wollok.game.*


class ElementoVisible {

	var property image
	var property position

	method mostrar() {
		game.addVisual(self)
	}

	method remover() {
		game.removeVisual(self)
	}

}


