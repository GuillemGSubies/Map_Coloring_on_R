##########################################################
# AUTORES: Guillem Garc�a y Javier Redondo, GII + GMAT   #
# FECHA: 15-02-2018                                      #
##########################################################


# Como hay que colorear un mapa gen�rico, asumimos que tiene las fronteras
# en regiones cont�nuas (es un grafo plano no dirigido). De este modo, 
# sabemos por el teorema de los cuatro colores que, como m�ximo, vamos 
# a necesitar 4 colores para colorear cualquier grafo plano o mapa.

# install.packages("data.table")
library(data.table)    

# Ejemplo de matriz de entrada para el programa:
# m <- matrix(c(0,1,0,0,1,0,0,1,0,1,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,1,1,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,1,0), nrow=7, ncol=7, byrow=TRUE)

pintame <- function(g){

# Asumimos que la entrada es una matriz de adyacencia 
# (sim�trica) de un grafo plano no dirigido
# Asumimos tambi�n que el grafo tiene 4 o m�s v�rtices ya
# que, de otro modo, el coloreado ser�a trivial

	# Ordenamos los v�rtices por su grado
	vertex <- vector()
	for (i in 1:length(g[1,])){
		vertex <- c(vertex, sum(g[i,]))
		vertex <- c(vertex, i)
		# Estos 0 ser�n donde almacenemos la informaci�n
		# del color que asignamos
		vertex <- c(vertex, 0)
	}
	vertex <- matrix(vertex, nrow=3, ncol=length(g[1,]), byrow=FALSE)
	vertex <- t(vertex)
	vertex <- as.data.table(vertex) 
	vertex <- vertex[order(vertex$V1, decreasing=TRUE),]
	# Hemos conseguido ordenar un vector con el grado de los v�rtices
	# sabiendo adem�s qu� �ndice tiene cada v�rtice para despu�s saber
	# a qui�n le damos qu� color
	# La columna 1 de la matrix es el grado de los v�rtices, la otra
	# es el �ndice o identificador de los mismos

	# Nos creamos vectores donde a�adiremos los adyacentes a un vector 
	# pintado con el color i ya que estos no podr�n ser pintados 
	# del mismo color
	no1 <- vector()
	no2 <- vector()
	no3 <- vector()
	no4 <- vector()
	
	# Hacemos el for "desordenado" porque as� pintamos
	# primero los v�rtices con mayor grado
	for (i in 1:length(vertex[,V1])){
		sepuede <- TRUE
		# Comprobamos si podemos pintar con el color 1:
		for (k in 1:length(g[vertex[i,V2],])){
			if ((g[vertex[i,V2],k] == 1) && (k %in% no1)){
				sepuede <- FALSE
				break
			}
		}
		
		# Si sepuede es FALSE salimos de bucle y probamos 
		# con el siguiente color
		if (sepuede){
			# Pintamos
			vertex[i,3] = 1
			# Metemos a los vecinos y al propio v�rtice 
			# en el array que dice que no pueden ser
			# pintados del color 1
			no1 <- c(no1, vertex[i,V2])
			for (j in 1:length(g[vertex[i,V2],])){
				if (g[vertex[i,V2],j] == 1)
					no1 <- c(no1, j)
			}
			# Como ya est� pintado, pasamos a la siguiente
			# iteraci�n del bucle usando next para pintar al
			# siguiente v�rtice
			next
		}
		
		sepuede <- TRUE
		# Comprobamos si se puede pintar con el color 2:
		for (k in 1:length(g[vertex[i,V2],])){
			if ((g[vertex[i,V2],k] == 1) && (k %in% no2)){
				sepuede <- FALSE
				break
			}
		}
		# Si sepuede es FALSE salimos de bucle y probamos 
		# con el siguiente color
		if (sepuede){
			# Pintamos
			vertex[i,3] = 2
			# Metemos a los vecinos y al propio v�rtice 
			# en el array que dice que no pueden ser
			# pintados del color 2
			no2 <- c(no2, vertex[i,V2])
			for (j in 1:length(g[vertex[i,V2],])){
				if (g[vertex[i,V2],j] == 1)
					no2 <- c(no2, j)
			}
			# Como ya est� pintado, pasamos a la siguiente
			# iteraci�n del bucle usando next para pintar al
			# siguiente v�rtice
			next
		}
		
		sepuede <- TRUE
		# Comprobamos si se puede pintar con el color 3:
		for (k in 1:length(g[vertex[i,V2],])){
			if ((g[vertex[i,V2],k] == 1) && (k %in% no3)){
				sepuede <- FALSE
				break
			}
		}
		
		# Si sepuede es FALSE salimos de bucle y probamos 
		# con el siguiente color
		if (sepuede){
			# Pintamos
			vertex[i,3] = 3
			# Metemos a los vecinos y al propio v�rtice 
			# en el array que dice que no pueden ser
			# pintados del color 3
			no3 <- c(no3, vertex[i,V2])
			for (j in 1:length(g[vertex[i,V2],])){
				if (g[vertex[i,V2],j] == 1)
					no3 <- c(no3, j)
			}
			# Como ya est� pintado, pasamos a la siguiente
			# iteraci�n del bucle usando next para pintar al
			# siguiente v�rtice
			next
		}
		
		sepuede <- TRUE
		# Comprobamos si se puede pintar con el color 4:
		# Asumimos que si no est� en ninguno de los anteriores,
		# tiene que estar aqu�
		# Pintamos
		vertex[i,3] = 4
		# Metemos a los vecinos y al propio v�rtice 
		# en el array que dice que no pueden ser
		# pintados del color 4
		no4 <- c(no4, vertex[i,V2])
		for (j in 1:length(g[vertex[i,V2],])){
			if (g[vertex[i,V2],j] == 1)
				no4 <- c(no4, j)
		}
	}
	
	# Devolvemos un data table que contiene qu� v�rtice tiene
	# qu� color
	setnames(vertex, old = "V2", new = "V�rtices")
	setnames(vertex, old = "V3", new = "Color")
	return (vertex[,V1:=NULL])
}