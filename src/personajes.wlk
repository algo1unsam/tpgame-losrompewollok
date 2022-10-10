
import wollok.game.*

object Carpy{
	var comidas = 0
	var position = game.origin()
	method agarrar(comida){
		
		//las cominas tienen distinto valor
		comidas +=comida.valor()
		
		game.removeVisual(comida)
	}
	method comidas() = comidas //Devuelve la cantidad de comidas
	
	method moverse(){
		position = position.right()
	}
	
	method image() = "carpy.jpg"
	
	
	
	method position(){
		return position
	}
	
	method position(nuevaPosicion){
		position = nuevaPosicion
	}
	
}

object juego{
	const anchoTotal = 18
	const altoTotal = 12
	method iniciar(){
		game.clear()
		game.title("aventuras carpincho")
		game.width(anchoTotal)
		game.height(altoTotal)
		game.ground("fondo_verde.jpg")
		game.addVisualCharacter(Carpy)
		game.onTick(1000,"Aparece comida",{self.aparecerComida()})
		
		game.onCollideDo(Carpy,{comida => Carpy.agarrar(comida)})
		
		
	}
	
	
	method aparecerComida(){
		const x = (0..game.height()-1).anyOne()
		const y = (0..game.width()-1).anyOne()		
		game.addVisual(
			new Comida(
				valor = [1,5,10].anyOne(),position = game.at(x,y))
				
				)
	}
	
	
	
}

class Comida{
	var property position
	var property valor
	
	method image() = "zanahoria.png"
}//agregados
