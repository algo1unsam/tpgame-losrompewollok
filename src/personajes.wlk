import wollok.game.*
import elementosVisibles.*
object carpy{
    var energiaT = 20
    var position = game.origin()

    method agarrar(comida){

        //las cominas tienen distinto valor
        energiaT +=    comida.energia()

        game.removeVisual(comida)
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
  
    	}else{
    		game.say(self,"NO TENGO ENERGIA")
    	}
    	
    }
}


object casa inherits ElementoVisible(image = "casa.png", position = game.at(12, game.height()).down(3)) {
	    method  teChocoCarpy(){
		 game.addVisual(mujer)
		 mujer.perseguirACarpy()
}
 		method energia(){}
}
object poder inherits ElementoVisible(image = "caca.png", position = game.at(10, game.height()).down(5)){
	
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

        game.onCollideDo(carpy,{comida => carpy.agarrar(comida)})
        game.addVisual(vida)
        game.addVisual(casa)
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

class Comida{

    var property position
    var property energia
    var property imagen

    method image() = imagen
}

const zanahoria = new Comida(energia = 10, imagen ="zana.png", position = game.at((0..game.height()-1).anyOne(),(0..game.height()-1).anyOne())) 
const manzana = new Comida( energia = 5, imagen ="manzana.png",position= game.at((0..game.height()-1).anyOne(),(0..game.height()-1).anyOne()))
