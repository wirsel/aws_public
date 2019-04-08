LOAD CSV With HEADERS FROM 'https://raw.githubusercontent.com/wirsel/aws_public/master/documentation_history/documentation_history_urls.csv' AS line FIELDTERMINATOR '|'

WITH line, tolower(line.solution) as solution
WITH line, solution, {name:solution, type:'C_solution'} as props_solution
MERGE(s:C_solution {identifier:solution})
SET s += props_solution

WITH line, s, solution,{name:solution, type:'C_documentation',headers:line.headers} as props_doc
MERGE(d:C_documentation {identifier:solution})
SET d += props_doc

WITH line, s, d, {name:line.url, type:'C_url'} as props_url
MERGE(u:C_url {identifier:line.url})
SET u += props_url

MERGE(s)-[de:HAS_DOCUMENTATION]->(d)
MERGE(d)-[ue:HAS_URL]->(u)
RETURN *
