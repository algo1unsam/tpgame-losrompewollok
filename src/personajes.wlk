import wollok.game.*
import elementosVisibles.*
import tablero.*
import teclado.*
import menus.*


object carpy{
    var energiaT = 30
    var position = game.origin()
    var tesoros = 0
    
    method reiniciarEstado(){
    	energiaT = 30
    	tesoros = 0
    }
    method energiaPoder(){
    	energiaT= 50
    }
	method estaMuerto(){
		energiaT = 0
	}
    method agarrar(cosas){

    //las cominas tienen distinto valor
        energiaT += cosas.energia()
        if (cosas == tesoro){
        	tesoros += 1
        }
        if (tesoros == 3){
        	juego.terminarGanador()
        	
        }

        game.removeVisual(cosas)
    }
	
    method energia() = energiaT //Devuelve la cantidad de comidas
	
	method tesoros() = tesoros//devuelve cantidad tesoros
	
    method moverse(){
        position = position.right()
    }

    method image() = "carpincho.png"

    method position(){
        return position
    }
    
    method atacado(){
    	return energiaT - 10
    }
   

    method position(nuevaPosicion){
        position = nuevaPosicion
    }
    method perderVida(cantidad) {
        energiaT -= cantidad
        if(energiaT <= 0){
            juego.terminar()
        }
        }
        
    method tirarPoder(){
    	if(energiaT>=45){
    		const poder = new ElementoVisible(image = "caca.png", position = self.position())  
    		game.addVisual(poder)
    		energiaT -=40
    		self.eliminarCaca(20000, poder)
    	}else{
    		game.say(self,"NO TENGO ENERGIA")
    	}
    	
    	
    }
    
    method eliminarCaca(tiempo,poder){
    	game.schedule(tiempo,{game.removeVisual(poder)})
    }
}



object tesoro inherits ElementoVisible(image = "tesoro.png", position = game.at(4, game.height()).down(5)){
	method energia() = 100
}
//muestra como en vida la canntidad de tesoros que va junstando
object cantidadTesoros{
	method text(){
		return "  tesoros: " + carpy.tesoros()
	}
	method position(){
	 return game.at(0, game.height()).down(4) //Cambio de la posicion
	}
}


object vibora inherits ElementoVisible(image = "vibora.png", position = game.at(12, game.height()).down(10)){
	method teAgarre(){
	carpy.perderVida(50)
}

}






object casa inherits ElementoVisible(image = "casa.png", position = game.at(12, game.height()).down(6)) {
	    method  teChocoCarpy(){
		 game.addVisual(mujer)
		 mujer.perseguirACarpy()
}
 		method energia(){}
}

object mujer inherits ElementoVisible(image = "mujer.png", position = game.at(11, game.height()).down(6)) {
	const acercarse="acercarse"
	method chetaParar(){
		game.removeTickEvent(acercarse)
		game.schedule(7000, {self.perseguirACarpy()})
	}
	
	method pisarMierda(caca){
		self.chetaParar()
		carpy.eliminarCaca(0, caca)
	}

	method perseguirACarpy(){game.onTick(1000,acercarse,{self.darUnPaso(carpy.position())}) }
    method darUnPaso(destino){
 
        	position = game.at(
            position.x() + (destino.x()-position.x())/2,
            position.y() + (destino.y()- position.y())/2
            
        )
        
    }
    
   
 override method position() = position

	method teAgarre(){
	carpy.perderVida(15)
}

}
object vida {
	method text(){
		return "Energia: " + carpy.energia()
	}
	method position(){
	 return game.at(15, game.height()).down(4)
	}

}



object juego{
    const anchoTotal = 17
    const altoTotal = 13
    method iniciar(){
        game.clear()
        game.title("aventuras carpincho")
        game.width(anchoTotal)
        game.height(altoTotal)
        game.ground("fondo_verde.jpg")
        game.addVisualCharacter(carpy)
	carpy.reiniciarEstado() 
        
        
        
        game.onTick(2000,"Aparece comida",{self.aparecerComida()})
        game.onTick(2000,"Aparece arboles",{self.aparecerArboles()})
        
        //game.schedule(10000,{game.removeTickEvent("Aparece comida")})
        //game.schedule(10000, {game.removeTickEvent("Aparece arboles")})


		//Agregado tesoro ranking==>

		game.addVisual(new ElementoVisible(image = "tesorito1.png",position= game.at(0, game.height()).down(4)))

        game.addVisual(vida)
        game.addVisual(cantidadTesoros)
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
        
        
        
        game.onCollideDo(mujer,{poder => mujer.pisarMierda(poder)})
        

    }
        method terminar(){
        game.clear()
        game.addVisual(gameOver) 
        game.addVisual(restart)
        game.addVisual(exit)
        teclado.configurarTeclasMenuInicial()
        
    }
    
     method terminarGanador(){
        game.clear()
        game.addVisual(gameOverGanador) 
        game.addVisual(restart)
        game.addVisual(exit)     
        //sonido.iniciar(sonidoDeFondo, true, 0)

        teclado.configurarTeclasMenuInicial()
    }
    
     method aparecerArboles(){
        const x = (0..game.height()-3).anyOne()
        const y = (0..game.width()-2).anyOne()
        game.addVisual(
            new Arboles(position = game.at(x+1,y-5))
        )

        game.addVisual(
            new Arboles(position= game.at(x+5,y-5))
            )


    }
    
    method aparecerComida(){
        const x = (0..game.height()-4).anyOne()
        const y = (0..game.width()-3).anyOne()
        game.addVisual(
             new Comida(energia = 10, imagen ="zana.png", position = game.at(x+3,y-9))
        )

        game.addVisual(
            new Comida( energia = 5, imagen ="manzana.png",position= game.at(x+7,y-10))
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
	
    var property position = ""
    var property energia
    var property imagen

    method image() = imagen
    
     method energia(){
    	return energia
    }
}
