# ====================================================================
#  Name:     startDockerContainer.sh
# 
# Purpose:
#    This script will run a docker container for development on a Mac.
# 
#  Arguments:
#     None
# 
#  Returns:
#     None
#
#  Author(s):  Tejas Roysam     (Initial version)
# 
#  History:  Date Written  2020-03-30
# ====================================================================

display_usage() { 
	echo -e "\nThis script will launch a NEW docker container with your chosen name, using the image you specify. (MAC)" 
	echo -e "Usage: ./startDockerContainer.sh <CONTAINER NAME> <IMAGE NAME>"
	echo -e "e.g.: ./startDockerContainer.sh mycontainer roysamt-dev-20200401\n"
        echo -e "To find your Docker image name, use \"docker images\". The container name is up to you.\n" 
	} 

	# if less than two arguments supplied, display usage 
	if [  $# -le 1 ] 
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
IMAGE_NAME=$2

#Close xquartz
osascript -e 'quit app "XQuartz"'

#Determine DISPLAY variable
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
#if wireless IP is not found, get the wired IP
if [ ! $IP ]
then
   IP=$(ifconfig | grep inet | grep -v 127.014.0.1 | awk '$1=="inet" {print $2}')
   MAC_DISPLAY="host.docker.internal"
   echo "wired or no Connection IP=$IP"
else
   MAC_DISPLAY=$IP
   echo "wireless connection IP= $IP"
fi

#add the IP to control list
open -a XQuartz
Xhost + $IP


#Run dockerfile
docker run --name $CONTAINER_NAME -it --privileged -e DISPLAY=$MAC_DISPLAY:0 $IMAGE_NAME

echo " "
echo "#################################################################"
echo "If this script outputs:"
echo "\"You have to remove (or rename) that container to be able to reuse that name\""
echo "You already have a running container with that name! Use ./restartContainer to jump back in, or remove it with:"
echo "\"docker stop <name>\""
echo "\"docker rm <name>\""
echo "\"Then re-run this script.\""
echo "#################################################################"
echo " "