object barrileteCosmico {

	var destinos = [ garlicsSea, silversSea, lastToninas, goodAirs ]

	method destinos() = destinos

	method destinosMasImportantes() {
		var destacados = destinos.filter({ destino => destino.precio() > 2000 })
		return destacados.map({ destino => destino.nombre() })
	}

	method aplicarDescuentos(descuento) {
		return destinos.map({ destino => destino.aplicarDescuento(descuento) })
	}

	method esEmpresaExtrema() = destinos.any({ destino => destino.requiereVacuna() })

	method conocerCartaDeDestinos() = destinos.map({ destino => destino.nombre() })

}

object garlicsSea {

	const nombre = "Garlic's Sea"
	var equipajeImprescindible = [ "caña de pescar", "piloto" ]
	var precio = 2500

	method precio() = precio

	method precio(_precio) = { precio = _precio }

	method nombre() = nombre

	method equipajeImprescindible() = equipajeImprescindible

	method aplicarDescuento(porcentajeDescuento) {
		precio = precio - (porcentajeDescuento * precio / 100)
		equipajeImprescindible.add("Certificado de Descuento")
		return precio
	}

	method requiereVacuna() = equipajeImprescindible.any({ equipaje => equipaje.contains("Vacuna") })

}

object silversSea {

	const nombre = "Silver's Sea"
	var equipajeImprescindible = [ "Protector Solar", "Equipo de Buceo" ]
	var precio = 1350

	method precio() = precio

	method precio(_precio) = { precio = _precio }

	method nombre() = nombre

	method equipajeImprescindible() = equipajeImprescindible

	method aplicarDescuento(porcentajeDescuento) {
		precio = precio - (porcentajeDescuento * precio / 100)
		equipajeImprescindible.add("Certificado de Descuento")
		return precio
	}

	method requiereVacuna() = equipajeImprescindible.any({ equipaje => equipaje.contains("Vacuna") })

}

object lastToninas {

	const nombre = "Last Toninas"
	var equipajeImprescindible = [ "Vacuna Gripal", "Vacuna B", "Necronomicron" ]
	var precio = 3500

	method precio() = precio

	method precio(_precio) = { precio = _precio }

	method nombre() = nombre

	method equipajeImprescindible() = equipajeImprescindible

	method aplicarDescuento(porcentajeDescuento) {
		precio = precio - (porcentajeDescuento * precio / 100)
		equipajeImprescindible.add("Certificado de Descuento")
		return precio
	}

	method requiereVacuna() = equipajeImprescindible.any({ equipaje => equipaje.contains("Vacuna") })

}

object goodAirs {

	const nombre = "Good Airs"
	var equipajeImprescindible = [ "Cerveza", "Protector Solar" ]
	var precio = 1500

	method precio() = precio

	method precio(_precio) = { precio = _precio }

	method nombre() = nombre

	method equipajeImprescindible() = equipajeImprescindible

	method aplicarDescuento(porcentajeDescuento) {
		precio = precio - (porcentajeDescuento * precio / 100)
		equipajeImprescindible.add("Certificado de Descuento")
		return precio
	}

	method requiereVacuna() = equipajeImprescindible.any({ equipaje => equipaje.contains("Vacuna") })

}

object pabloHari {

	var nombreUsuario = "PHari"
	var conoce = [ lastToninas, goodAirs ]
	var dineroEnCuenta = 1500
	var usuariosQueSigue = []

	method nombre() = "Pablo Hari"

	method nombreUsuario() = nombreUsuario

	method nombreUsuario(_nombre) = { nombreUsuario = _nombre }

	method dineroEnCuenta() = dineroEnCuenta
	
	method conoce() = conoce.map({ destino => destino.nombre() })


	method volarA(destino) {
		destino.precio()<dineroEnCuenta
		conoce.add(destino)
		dineroEnCuenta = dineroEnCuenta - destino.precio()
	}

	method seguirUsuario(usuario) {
		usuariosQueSigue.add(usuario)
		usuario.seguirUsuario(self)
	}

	method kilometrosAcumulados()=conoce.sum({ destino => destino.precio()})*0.1
	

}

