$resourceGroupName = "cosmosdb"
$location = "westus"
$accountName= "laaz203cosmosdbiop"
$databaseName = "myDatabaseiop"

az group create `
 -n $resourceGroupName `
 -l $location

# Create a SQL API Cosmos DB account with session consistency and multi-master enabled
az cosmosdb create `
 -g $resourceGroupName `
 --name $accountName `
 --kind GlobalDocumentDB `
 --locations regionName=EastUS failoverPriority=0 isZoneRedundant=True `
 --locations regionName=WestUS2 failoverPriority=1 isZoneRedundant=True `
 --enable-multiple-write-locations `
 --default-consistency-level Session `
 --enable-automatic-failover true

# Create a database
az cosmosdb database create `
 -g $resourceGroupName `
 --name $accountName `
 --db-name $databaseName

# List account keys
az cosmosdb list-keys `
 --name $accountName `
 -g $resourceGroupName

# List account connection strings
az cosmosdb list-connection-strings `
 --name $accountName `
 -g $resourceGroupName

az cosmosdb show `
 --name $accountName `
 -g $resourceGroupName `
 --query "documentEndpoint"

# Clean up
az group delete -y -g $resourceGroupName
