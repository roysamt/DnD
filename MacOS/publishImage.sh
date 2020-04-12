# ====================================================================
#  Name:     plublishImage.sh
# 
# Purpose:
#    This script will push the specified image to the local registry.
# 
#  Arguments:
#     - Image name
# 
#  Returns:
#     Tags and pushes image to local registry
#
#  Author(s):  Tejas Roysam     (Initial version)
# 
#  History:  Date Written  2020-03-30
# ====================================================================

display_usage() { 
	echo "This script will push a specified image to the local Docker registry. (MAC)" 
	echo -e "\nUsage: ./plublishImage.sh <IMAGE_NAME>\n"
        echo -e "\nUse this if you want to share your development image with others, or back it up."
        echo -e "\nNOTE: You must be logged in to docker to execute this script."
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

IMAGE_NAME_IN=$1
IMAGE_NAME="localhost:8080/${IMAGE_NAME_IN}"

docker tag $IMAGE_NAME_IN $IMAGE_NAME  

docker push $IMAGE_NAME