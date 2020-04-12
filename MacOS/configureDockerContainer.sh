# ====================================================================
#  Name:     configureDockerContainer.sh
# 
# Purpose:
#    This script will walk through configuring a docker image for development on a MAC.
# 
#  Arguments:
#     - Relative path to a valid Dockerfile
# 
#  Returns:
#     Builds and names an image from the provided Dockerfile
#
#  Author(s):  Tejas Roysam     (Initial version)
# 
#  History:  Date Written  2020-03-30
# ====================================================================

display_usage() { 
	echo "This script will walk you through configuring a Docker image that you can use for development. (MAC)" 
	echo -e "\nUsage: ./configureDockerContainer.sh <Path-to-Dockerfile>\n"
	echo -e "\ne.g.: ./configureDockerContainer.sh ../os_images/ubuntu/Dockerfile\n"
    echo -e "\nThe image will be initally named according to your username and the date. Rename it with ./saveContainerAs.\n" 
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

DOCK_PATH=$1
IMG_NAME="$(whoami)-dev-$(date +%Y%m%d)"

if [ ! -f $DOCK_PATH ]
then
    echo "Dockerfile not found at $DOCK_PATH. Cannot build image."
    exit 1
fi

echo "------ Building image ${IMG_NAME} ------"
cd $DOCK_PATH
docker build -t $IMG_NAME .

echo -e "Environment setup complete\nReady for startDockerContainer.sh"

echo -e "\n\n\033[31m\033[1m Created development image: ${IMG_NAME}\033[0m"
