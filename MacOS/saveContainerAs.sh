# ====================================================================
#  Name:     saveContainerAs.sh
# 
# Purpose:
#    This script wraps docker commit to save a container as a new image
# 
#  Arguments:
#     None
# 
#  Returns:
# 
#  Dependancy:
#     Mac
#     XQuartz
#     centos 7
#     docker
# 
#  Called By:
#     command line
# 
#  Global Inputs/Reads:
#     None
# 
#  Global Outputs/Writes:
#     None
# 
#  Limitations, Assumptions, External Events, and Notes:
#     None
#
#   Algorithm:
#     - Find and commit container to image
#
#  Author(s):  Tejas Roysam     (Initial version)
# 
#  History:  Date Written  2020-03-20
# ====================================================================

display_usage() { 
	echo "This script will commit a container to a new image (MAC)" 
	echo -e "\nUsage: ./saveContainerAs.sh <CONTAINER NAME> <IMAGE SAVENAME>\n"
	echo -e "\ne.g.:  ./saveContainerAs.sh march-20-workspace usernameplssdev \n"
        echo -e "\nNOTE: If your <IMAGE SAVENAME> is an existing image, it will be overwritten."
        echo -e "       If you want to keep your changes separate from the image you are using now, change <IMAGE SAVENAME>\n" 
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
IMAGE_SAVENAME=$2


CONT_HASH=$(docker ps -aqf "name=^${CONTAINER_NAME}$")

if [ -z "$CONT_HASH" ]
then
      echo "No container named ${CONTAINER_NAME} found. See full list of containers below:"
      docker ps -a
      exit 1
fi


docker commit $CONT_HASH $IMAGE_SAVENAME

docker stop $CONTAINER_NAME

echo -e "\n \033[31m\033[1m Saved image ${IMAGE_SAVENAME} and stopped container ${CONTAINER_NAME}.\033[0m\n"

echo "#################################################################"
echo "Note: This container is stopped but not removed. To remove it, run:"
echo ""
echo "\"docker rm $CONTAINER_NAME\""
echo "#################################################################"