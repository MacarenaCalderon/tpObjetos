object barrileteCosmico {
	
	var property garlicsSea = new Localidad ("Garlics Sea", [ "caña de pescar", "piloto" ], 2500, 100) 
	
	var silversSea = new Localidad ("Silver's Sea", [ "Protector Solar", "Equipo de Buceo" ], 1350, 500)

    var property lastToninas = new Localidad ("Last Toninas", [ "Vacuna Gripal", "Vacuna B", "Necronomicron" ], 3500, 1000)

    var  goodAirs = new Localidad ("Good Airs", [ "Cerveza", "Protector Solar" ], 1500, 0) 

	var property destinos = [ garlicsSea, silversSea, lastToninas, goodAirs]
	
	var property pabloHari = new Usuario ("PHari",goodAirs,100000,#{lastToninas, goodAirs},#{},500)
	
	var  tren = new MedioTransporte (4, 5) 
    
    var property transportes=[tren]
    
    var property viaje1 = new Viaje (goodAirs, silversSea,transportes.anyOne())


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

}

class MedioTransporte {

	var property tardanza
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

	method precio(unaCiudadPartida, unaCiudadLlegada, unTransporte) {
		return self.kmDelViaje() * unTransporte.precioPorKm() + unaCiudadLlegada.precio()
	}

}

class Usuario {

	var property nombreUsuario
	var property localidadOrigen
	var property dineroEnCuenta
	var property viajes=#{}
	var property usuariosQueSigue 
	var property kmsAcumulados
	
	constructor (unNombreUsuario, unaLocalidadOrigen, unDineroEnCuenta, unosViajes, unosUsuariosQueSigue, unosKmsAcumulados ){
		nombreUsuario=unNombreUsuario
		localidadOrigen=unaLocalidadOrigen
		dineroEnCuenta=unDineroEnCuenta
		usuariosQueSigue=unosUsuariosQueSigue
		kmsAcumulados=unosKmsAcumulados
	}

	method puedeViajar(viaje) = viaje.precio(localidadOrigen, viaje.ciudadLlegada(), viaje.transporte()) < dineroEnCuenta && viaje.ciudadPartida()==self.localidadOrigen()

	method volar(viaje) {
		if (self.puedeViajar(viaje)) {
			viajes.add(viaje)
			dineroEnCuenta = dineroEnCuenta - viaje.precio(localidadOrigen, viaje.ciudadLlegada(), viaje.transporte())
		}
	}

	method seguirUsuario(usuario) {
		if (!self.usuariosQueSigue().contains(usuario)) {
			usuariosQueSigue.add(usuario)
			usuario.seguirUsuario(self)
		}
	}

	method kmsAcumulados() = kmsAcumulados + viajes.sum({ viaje => viaje.kmDelViaje() })

}



