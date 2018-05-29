//equipo
import clubes.*
import actividades.*


class Equipo inherits Actividad {

	var property plantel=#{}
	var property capitan
	var sanciones=0
	var campeonatos=0
	var property futbol=false
	
	method esDeFutbol()=futbol
	method sancionar(){
		sanciones+=1
	}
	method sancionPorFutbol()=
	if(self.esDeFutbol()){((plantel.filter({jugador=>jugador.esEstrella()})*5)
			-sanciones*10)}else{0}
	method nroSanciones()=sanciones
	
	override method calificar(){
		calificacion=
		(campeonatos*5)
		+ (plantel.size()*2)
		+ if(capitan.esEstrella()){5}else{0}
		- (sanciones.size()*20)
		+ self.sancionPorFutbol()
	}
	
	method esExperimentado()=
	plantel.all({e=>e.partidosJugados()>9})
	
	override method removerSocio(socio)=
	plantel.remove(socio)
	
	override method nuevoSocio(socio)=
	plantel.add(socio)

}

class Jugador inherits Socio{

	var property pase
	var property partidosJugados
	

	override method esEstrella() = partidosJugados >= 50 or club.perfil().paseEstrella(self)
	method sinPartidos(){
		partidosJugados=0
	}
}

