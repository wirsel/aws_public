with [
'amz sqs|https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-document-history.html|date#description',
'amz sns|https://docs.aws.amazon.com/sns/latest/dg/document-history.html|change#description#date',
'amz cloudwatch|https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/DocumentHistory.html|change#description#date',
'amz cloudtrail|https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-document-history.html|change#description#date',
'aws kms|https://docs.aws.amazon.com/kms/latest/developerguide/dochistory.html|change#description#date',
'aws step functions|https://docs.aws.amazon.com/step-functions/latest/dg/document-history.html|change#description#date',
'amz s3|https://docs.aws.amazon.com/AmazonS3/latest/dev/WhatsNew.html|change#description#date',
'aws iam|https://docs.aws.amazon.com/IAM/latest/UserGuide/document-history.html|change#description#date',
'amz rds|https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/WhatsNew.html|change#description#date',
'amz aurora|https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/WhatsNew.html|change#description#date',
'amz athena|https://docs.aws.amazon.com/athena/latest/ug/DocHistory.html|change#description#date',
'amz api gateway|https://docs.aws.amazon.com/apigateway/latest/developerguide/history.html|change#description#date',
'amz vpc|https://docs.aws.amazon.com/vpc/latest/userguide/WhatsNew.html|feature#api_version#description#date',
'aws workspaces|https://docs.aws.amazon.com/workspaces/latest/adminguide/workspaces-document-history.html|change#description#date'
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
