with [
"amz sqs|https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-document-history.html|date#description",
"amz sns|https://docs.aws.amazon.com/sns/latest/dg/document-history.html|change#description#date"
] as csv
unwind csv as item
with split(item,'|') as lst
with {solution:lst[0], url:lst[1]} as line
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
