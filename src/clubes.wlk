import actividades.*
import equipos.*

//clubes
class Club {

	var property gastoMensual
	var equipos = #{}
	var actividadesSociales = #{}
	var property perfil
	var property socios = #{}

	method sancionar() {
		if (self.cantidadDeSocios() < 500) {
			self.actividades().anyOne().sancionar()
		} else {
			equipos.foreach({ equipo => equipo.sancionar()})
			actividadesSociales.foreach({ act => act.sancionar()})
		}
	}

	method cantidadDeSocios() = socios.size()

	method actividades() = equipos + actividadesSociales

	method evaluacion() = self.evaluacionBruta() / socios.size()

	method evaluacionBruta() = perfil.evaluacionBruta(self)
	
	method jugadores()=
	equipos.map({e=>e.plantel()})
	
	method sociosParticipantes()=
	actividadesSociales.map({e=>e.sociosParticipantes()})
	
	method sociosDestacados() = self.jugadores().filter({ e => e.capitan() }) 
	+ self.sociosParticipantes().filter({ e => e.socioOrganizador() })
	
	method sociosDestacadosEstrellas()=
	self.sociosDestacados().filter({e=>e.esEstrella()})
	
	method esPrestigioso()=
	equipos.any({e=>e.esExperimentado()})
	or actividadesSociales.any({e=>e.tieneCincoEstrellas()})
	
	method transferirJugadores(jugador,equipo){
		return if((equipos.contain({equipo}))
			or (equipo.capitan()==jugador))
			{self.error("no se puede transferir")}
			else{self.iniciarTransferencia(jugador, equipo)}
			 
	}
	
	method iniciarTransferencia(socio, equipo){
		actividadesSociales.forEach({act=>act.removerSocio(socio)})
		equipos.forEach({act=>act.removerSocio(socio)})
		equipo.nuevoSocio(socio)
		socios.remove(socio)
		equipo.socios().add(socio)
		socio.sinPartidos()
	}
	
}

class Perfil {

	method paseEstrella(jugador)

	method evaluacionBruta(club) = club.actividades().sum({ act => act.calificacion() })

}

object profesional inherits Perfil {

	override method paseEstrella(jugador) = 200 < jugador.pase()

	override method evaluacionBruta(club) = super(club) * 2 - club.gastoMensual()

}

object comunitario inherits Perfil {

	override method paseEstrella(jugador) = 2 < jugador.actividades()

}

object tradicional inherits Perfil {

	override method paseEstrella(jugador) = comunitario.paseEstrella(jugador) or profesional.paseEstrella(jugador)

	override method evaluacionBruta(club) = super(club) - club.gastoMensual()

}

// actividad
class Actividad {

	var calificacion

	method calificar()

	method calificacion() = calificacion
	method removerSocio(socio)
	method nuevoSocio(socio)
}

//socio
class Socio {

	var property club
	var property actividades

	method esEstrella()
	
}

