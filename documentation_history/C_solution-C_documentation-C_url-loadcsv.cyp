Load csv WIHT HEADER from 'https://raw.githubusercontent.com/wirsel/aws_public/master/documentation_history/documentation_history_urls.csv' as line FIELDTERMINATOR '|'
merge(s:C_solution {identifier:toLower(line.solution)})
on create set s.name=s.identifier, s.type='C_solution'
merge(d:C_documentation {identifier:tolower(line.solution)})
on create set d.name=d.identifier, d.type='C_documentation', d.headers=line.headers
merge(u:C_url {identifier:line.url})
on create set u.name=u.identifier, u.type='C_url'
merge(s)-[de:HAS_DOCUMENTATION]->(d)
merge(d)-[ue:HAS_URL]->(u)
return *
