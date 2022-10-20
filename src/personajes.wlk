import wollok.game.*
import elementosVisibles.*
import tablero.*
import teclado.*


object carpy{
    var energiaT = 200
    var position = game.origin()

    method agarrar(cosas){

        //las cominas tienen distinto valor
        energiaT +=    cosas.energia()

        game.removeVisual(cosas)
    }

    method energia() = energiaT //Devuelve la cantidad de comidas

    method moverse(){
        position = position.right()
    }

    method image() = "carpincho.png"

    method position(){
        return position
    }

    method position(nuevaPosicion){
        position = nuevaPosicion
    }
    method perderVida() {
        energiaT -= 15
        if(energiaT <= 0){
            juego.terminar()
        }
        }
    method tirarPoder(){
    	if(energiaT>=45){
    		game.addVisual(poder)
    		energiaT -=40
    		game.schedule(2000,{game.removeVisual(poder)})
    	}else{
    		game.say(self,"NO TENGO ENERGIA")
    	}
    	
    }
}



object tesoro inherits ElementoVisible(image = "tesoro.png", position = game.at(4, game.height()).down(5)){
	method energia() = 100
}



object vibora inherits ElementoVisible(image = "vibora.png", position = game.at(12, game.height()).down(10)){
	method energia() = -100
}
object viborita inherits ElementoVisible(image = "vibora.png", position = game.at(12, game.height()).down(12)){
	method energia() = -100
}
object viboritata inherits ElementoVisible(image = "vibora.png", position = game.at(12, game.height()).down(9)){
	method energia() = -100
}



object poder inherits ElementoVisible(image = "caca.png", position = carpy.position()){
	
}

object casa inherits ElementoVisible(image = "casa.png", position = game.at(12, game.height()).down(3)) {
	    method  teChocoCarpy(){
		 game.addVisual(mujer)
		 mujer.perseguirACarpy()
}
 		method energia(){}
}

object mujer inherits ElementoVisible(image = "mujer.png", position = game.at(10, game.height()).down(5)) {


	method perseguirACarpy(){game.onTick(1000,"acercarse",{self.darUnPaso(carpy.position())}) }
    method darUnPaso(destino){
    	
        	position = game.at(
            position.x() + (destino.x()-position.x())/2,
            position.y() + (destino.y()- position.y())/2
        )
    }
    
   
 override method position() = position

	method teAgarre(){
	carpy.perderVida()
}

}
object vida {
	method text(){
		return "Energia: " + carpy.energia()
	}
	method position(){
	 return game.at(15, game.height()).down(1)
	}

}


object juego{
    const anchoTotal = 17
    const altoTotal = 16
    method iniciar(){
        game.clear()
        game.title("aventuras carpincho")
        game.width(anchoTotal)
        game.height(altoTotal)
        game.ground("fondo_verde.jpg")
        game.addVisualCharacter(carpy)
        game.onTick(5000,"Aparece comida",{self.aparecerComida()})
        game.onTick(5000,"Aparece arboles",{self.aparecerArboles()})

        game.addVisual(vida)
        game.addVisual(casa)
        
        game.onCollideDo(carpy,{vibora => carpy.agarrar(vibora)})
        game.onCollideDo(carpy,{tesoro => carpy.agarrar(tesoro)})
        game.onCollideDo(carpy,{comida => carpy.agarrar(comida)})
        game.onCollideDo(carpy,{arbolito=> arbolito.teChocoCarpy()})
        game.onCollideDo(carpy,{arbol=> arbol.teChocoCarpy()})
        game.onCollideDo(carpy,{casa=> casa.teChocoCarpy()})
		game.onCollideDo(carpy,{mujer=> mujer.teAgarre()})
		keyboard.s().onPressDo({
         carpy.tirarPoder()
        })

    }
        method terminar(){
        game.clear()
        game.addVisual(poder)
        game.say(carpy,"PERDI")
    }
    
     method aparecerArboles(){
        const x = (0..game.height()-1).anyOne()
        const y = (0..game.width()-1).anyOne()
        game.addVisual(
            new Arboles(position = game.at(x,y))
        )

        game.addVisual(
            new Arboles(position= game.at(x+2,y+3))
            )


    }
    
    method aparecerComida(){
        const x = (0..game.height()-1).anyOne()
        const y = (0..game.width()-1).anyOne()
        game.addVisual(
             new Comida(energia = 10, imagen ="zana.png", position = game.at(x,y))
        )

        game.addVisual(
            new Comida( energia = 5, imagen ="manzana.png",position= game.at(x+2,y+3))
            )


    }
}

class Arboles{
	var property position
	var lista = [tesoro,vibora]

    method image() = "arbol.png"
    method  teChocoCarpy(){
		 game.removeVisual(self)
		 game.addVisual(lista.anyOne())
}
}


class Comida{

    var property position
    var property energia
    var property imagen

    method image() = imagen
}
