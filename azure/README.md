https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli?view=azure-cli-latest

#AZURE

There is used docker to work with AZURE. To start work you should build docker image:
* cd docker
* ./docker build

To start docker container:
* ./run-by-docker.sh

Module's hand out contains:
* [run-by-docker](run-by-docker.sh) which contains command to start docker container with  [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)
* [create_cluster](create_cluster.sh) which contains commands to create HDInsight cluster
* [delete_cluster](delete_cluster.sh) which contains commands to delete HDInsight cluster

To work with Azure CLI you should exec:
* ./run-by-docker.sh
* az login
    * login in browser
* cd /home
    * change current dir to run scripts; there are scripts mounted from host machime

To create cluster:
* ./create_cluster.sh

To delete cluster:
* ./delete_cluster.sh

Get started with [Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-azure-function-azure-cli?tabs=bash%2Cbrowser&pivots=programming-language-python):
* func init LocalFunctionProj --python
* cd LocalFunctionProj
* func new --name HttpExample --template "HTTP trigger"
* Run the function locally: func start
* view a result: http://localhost:7071
