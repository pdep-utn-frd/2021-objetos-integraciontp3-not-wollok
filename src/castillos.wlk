class CastilloGeneral{
	var property rey
	var sequito = []
	var ambientes = []
	const estabilidadMinima 
	var  property estabilidad
	var alturaMuralla
	
	method unidades(){
		return sequito.size() + 80 // 80 por el rey 
	}
	method derrota(){
		return self.unidades() < 100
	}
	method prepararDefensa(){
		estabilidad = estabilidad + sequito.sum({x=>x.estrategiaDefensa()})
	}
	
	method fiestas(){
		if (self.bajoAmenaza()){return "Bajo amenaza!"}
		else{
			self.reyCelebra()
			sequito.forEach({x=>x.celebrar()})
			estabilidad -= sequito.size()
			return "A celebrar!"
		}
	}
	
	method reyCelebra(){
		rey.celebrar()
	}
	
	method bajoAmenaza(){
		return estabilidad > estabilidadMinima*1.25
	}
	method recibirAtaque(){
		estabilidad = estabilidad - self.resistencia()*0.25 - estabilidad*0.2
		sequito.forEach({x=>x.vivirAtaque()})
		self.bajaDeUnidades()
	}
	
	method bajaDeUnidades(){
		sequito = sequito.drop(15)
	}
	
	method resistencia(){
		return ambientes.size() + alturaMuralla + sequito.size()/2 + ambientes.sum({z=>z.dimension()}) // parte del plus
	}
	method atacar(cast){
		rey.atacarCastillo(cast) // Polimorfismo
	}
	method construirNuevoAmbiente(amb){
		ambientes.add(amb)
	}
	method nuevoSequito(seq){
		sequito.add(seq)
	}
	method agrandarMuralla(m){
		alturaMuralla += m
	}
	method cambioDeRey(reyN){
		rey = reyN
		return "El rey cambio!"
	}
	method deLujo(){
		return ambientes.size() > 7
	}
	method circular(){
		if (ambientes.all({x=>x.ambienteSeguro()})){return "Es seguro circular"}
		else {return "Puede haber infiltrados"}
	}
	
}


class GuardiaGeneral{
	var capacidad
	var property agotamiento
	
	method celebrar(){
		agotamiento = 0
	}
	
	method vivirAtaque(){
		agotamiento += 10
	}
	
	method estrategiaDefensa(){
		return capacidad - 0.25*agotamiento
	}
}

class BurocrataGeneral{
	var nombre
	var edad
	var expEnCastillo
	var panico
	
	
	method aporte(){
		if (panico) return 0 
		else return 20
	}
	
    method estrategiaDefensa(){
        return self.aporte()

    }
    
    method celebrar(){
        panico = false
    }
         
    method vivirAtaque(){
    panico = expEnCastillo <= 10	
	}
}

class Rey{
	var property castillosConocidos = [] //Para darle utilidad en los test
	var ambientesDeseados = []
	
	method atacarCastillo(cast){
		cast.recibirAtaque()
		return "El castillo enemigo fue atacado"
	}
	
	method celebrar(){
		castillosConocidos = castillosConocidos.drop(1) 
	}
	method conocerCastillo(cast){
		castillosConocidos.add(cast)
	}
}

