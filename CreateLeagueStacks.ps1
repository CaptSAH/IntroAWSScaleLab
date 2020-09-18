$Teamlist = "lions","tigers","bears","turtles"
foreach ($team in $Teamlist)
{
aws cloudformation create-stack --stack-name $team"labdemostack" --template-body file://S3TwobucketwithParameters.yml --parameters ParameterKey=TeamNameParameter,ParameterValue=$team
}