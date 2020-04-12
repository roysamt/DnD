# ====================================================================
#  Name:     restartContainer.sh
# 
# Purpose:
#    This script wraps docker exec and docker run to restart a stopped container and enter it
# 
#  Arguments:
#     - Container name
# 
#  Returns:
#     Places user in new interactive shell inside previously stopped container.
#
#  Author(s):  Tejas Roysam     (Initial version)
# 
#  History:  Date Written  2020-03-30
# ====================================================================

display_usage() { 
	echo "This script will start a stopped docker container with the specified name, and open a shell inside it. (MAC)" 
	echo -e "\nUsage: ./restartContainer.sh <CONTAINER NAME>\n"
	echo -e "\ne.g.:  ./restartContainer.sh march-20-workspace\n"
        echo -e "\nNOTE: If your <CONTAINER_NAME> is not found, a list of all containers will be displayed." 
	} 

	# if less than one argument supplied, display usage 
	if [  $# -lt 1 ] 
	then 
		display_usage
		exit 1
	fi 
 
	# check whether user had supplied -h or --help . If yes display usage 
	if [[ ( $@ == "--help") ||  $@ == "-h" ]] 
	then 
		display_usage
		exit 0
	fi 

CONTAINER_NAME=$1

CONT_FOUND=$(docker ps -a | grep $CONTAINER_NAME)

if [ -z "$CONT_FOUND" ]
then
      echo "No container named ${CONTAINER_NAME} found. See full list of containers below:"
      docker ps -a
      exit 1
fi

echo -e "\n \033[31m\033[1m Spawning bash shell inside ${CONTAINER_NAME}...\033[0m\n"

docker start $CONTAINER_NAME
docker exec -it $CONTAINER_NAME /bin/bash
