LOAD CSV With HEADERS FROM 'https://raw.githubusercontent.com/wirsel/aws_public/master/documentation_history/documentation_history_urls.csv' AS line FIELDTERMINATOR '|'
MERGE(s:C_solution {identifier:toLower(line.solution)})
ON CREATE SET s.name=s.identifier, s.type='C_solution'
MERGE(d:C_documentation {identifier:tolower(line.solution)})
ON CREATE SET d.name=d.identifier, d.type='C_documentation', d.headers=line.headers
MERGE(u:C_url {identifier:line.url})
ON CREATE SET u.name=u.identifier, u.type='C_url'
MERGE(s)-[de:HAS_DOCUMENTATION]->(d)
MERGE(d)-[ue:HAS_URL]->(u)
RETURN *
