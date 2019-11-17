object barrileteCosmico {
	

	var property  destinos = [ new Localidad ("Garlics Sea", [ "caña de pescar", "piloto" ], 2500, 100), 
		new Localidad ("Silver's Sea", [ "Protector Solar", "Equipo de Buceo" ], 1350, 500), 
		new Localidad ("Last Toninas", [ "Vacuna Gripal", "Vacuna B", "Necronomicron" ], 3500, 1000),
        new Localidad ("Good Airs", [ "Cerveza", "Protector Solar" ], 1500, 0) 
	]
	 
    
    var transportes=[new MedioTransporte (4, 5), new MedioTransporte (4, 5)]
    
	method destinosMasImportantes() {
		return destinos.filter({ destino => destino.esDestacado() })
	}
	
	method mostrarPrecios(){
		return destinos.map({destino=>destino.precio()})
	}

	method aplicarDescuentos(descuento) {
		return destinos.forEach({ destino => destino.aplicarDescuento(descuento) })
	}

	method esEmpresaExtrema() = destinos.any({ destino => destino.requiereVacuna() })

	method conocerCartaDeDestinos() = destinos.map({ destino => destino.nombre() })
	
	method armarViaje(_destino,_llegada){
		return new Viaje(_destino,_llegada,transportes.anyOne())
	}

}

class MedioTransporte {

	var  tardanza
	var property precioPorKm

	constructor(unaTardanza, unPrecioPorKm) {
		tardanza = unaTardanza
		precioPorKm = unPrecioPorKm
	}

}



class Localidad {

	var property nombre
	var property equipajeImprescindible
	var property precio
	var property kmUbicacion

	constructor(unNombre, unEquipajeImprescindible, unPrecio, unKmUbicacion) {
		nombre = unNombre
		equipajeImprescindible = unEquipajeImprescindible
		precio = unPrecio
		kmUbicacion = unKmUbicacion
	}

	method aplicarDescuento(porcentajeDescuento) {
		precio = precio - (porcentajeDescuento * precio / 100)
		equipajeImprescindible.add("Certificado de Descuento")
	}

	method requiereVacuna() = equipajeImprescindible.any({ equipaje => equipaje.contains("Vacuna") })

	method esDestacado() = precio > 2000

	method distanciaA(ciudad) = kmUbicacion - ciudad.kmUbicacion()

}


class Viaje {

	var property ciudadPartida
	var property ciudadLlegada
	var property transporte
	
	constructor (unaCiudadPartida, unaCiudadLlegada, unTransporte){
		ciudadPartida=unaCiudadPartida
		ciudadLlegada=unaCiudadLlegada
		transporte=unTransporte
	}
	
	method kmDelViaje(){
		return ciudadPartida.distanciaA(ciudadLlegada).abs()
	}

	method precio() {
		return self.kmDelViaje() * transporte.precioPorKm() + ciudadLlegada.precio()
	}

}

class Usuario {

	var  nombreUsuario
	var property localidadOrigen
	var property dineroEnCuenta
	var property viajes=#{}
	var property usuariosQueSigue 
	
	constructor (unNombreUsuario, unaLocalidadOrigen, unDineroEnCuenta, unosViajes, unosUsuariosQueSigue){
		localidadOrigen=unaLocalidadOrigen
		dineroEnCuenta=unDineroEnCuenta
		usuariosQueSigue=unosUsuariosQueSigue
	}

	method puedeViajar(viaje) = viaje.precio() < dineroEnCuenta && viaje.ciudadPartida()==self.localidadOrigen()

	method viajar(viaje) {
		if (self.puedeViajar(viaje)) {
			viajes.add(viaje)
			dineroEnCuenta = dineroEnCuenta - viaje.precio()
			self.localidadOrigen(viaje.ciudadLlegada())
		}
	}

	method seguirUsuario(usuario) {
		if (!self.usuariosQueSigue().contains(usuario)) {
			usuariosQueSigue.add(usuario)
			usuario.seguirUsuario(self)
		}
	}

	method kmsAcumulados() = viajes.sum({ viaje => viaje.kmDelViaje() })

}



