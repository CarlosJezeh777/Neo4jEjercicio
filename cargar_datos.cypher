//archivos csv
//movies.csv
movieId,title,year
1,The Matrix,1999
2,John Wick,2014
3,Speed,1994

//actors.csv
actorId,name
10,Keanu Reeves
11,Laurence Fishburne
12,Carrie-Anne Moss

//acted_in.csv
actorId,movieId
10,1
10,2
10,3
11,1
12,1


//cargar movies
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/CarlosJezeh777/Neo4jEjercicio/refs/heads/main/archivos/movies.csv' as row 
CREATE (:Movie {id: tointeger(row.movieId), title: row.title, year: toInteger(row.year)})

//cargar actors
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/CarlosJezeh777/Neo4jEjercicio/refs/heads/main/archivos/actors.csv' as row 
CREATE (:Actor {id: tointeger(row.actorId), name: row.name})

//cargar relaciones  de actores que acturaon en peliculas
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/CarlosJezeh777/Neo4jEjercicio/refs/heads/main/archivos/acted_in.csv' AS row
MATCH (a:Actor {id: toInteger(row.actorId)})
MATCH (m:Movie {id: toInteger(row.movieId)})
CREATE (a)-[:ACTED_IN]->(m);

//cargar relaciones de actores que actuaron con otros actores
MATCH (a:Actor)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(b:Actor)
WHERE a <> b
MERGE (a)-[:ACTED_WITH]->(b)
MERGE (b)-[:ACTED_WITH]->(a);

// Ver nodos de películas
MATCH (m:Movie) RETURN m;

//ver nodos de actores
MATCH (a:Actor) RETURN a;

//consultas de relaciones
MATCH (a:Actor)-[r:ACTED_IN]->(m:Movie) RETURN a, r, m;

MATCH (a:Actor)-[r:ACTED_WITH]->(b:Actor) RETURN a, r, b;