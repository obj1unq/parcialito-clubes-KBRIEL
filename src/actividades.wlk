//actividades
import clubes.*
import equipos.*

class ActividadSocial inherits Actividad {

	var property valorCalificacion
	var property socioOrganizador
	var property sociosParticipantes
	var sanciones
	var suspender = false

	method sancionar() {
		suspender = true
	}

	method levantarSancion() {
		suspender = false
	}

	override method calificacion() = if (suspender) {
		0
	} else {
		valorCalificacion
	}
	method tieneCincoEstrellas()=
	sociosParticipantes.filter({e=>e.esEstrella()})>4
	
	override method removerSocio(socio)=
	sociosParticipantes.remove(socio)
	
	override method nuevoSocio(socio)=
	sociosParticipantes.add(socio)

}

class SocioComun inherits Socio {

	var property aniosDeSocio

	override method esEstrella() = aniosDeSocio > 20

}

