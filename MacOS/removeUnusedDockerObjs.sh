# ====================================================================
#  Name:     removeUnusedDockerObjs.sh
# 
# Purpose:
#    This script wraps calls to docker rm and docker rmi to cleanup the docker working area
# 
#  Arguments:
#     None
# 
#  Returns:
#     Deletes unused Docker image layers and containers, and returns hashes of deleted objects.
#
#  Author(s):  Tejas Roysam     (Initial version)
# 
#  History:  Date Written  2020-03-30
# ====================================================================

display_usage() { 
	echo "This script will remove all exited containers and dangling images. (MAC)" 
	echo -e "\nUsage: ./removeUnusedDockerObjs.sh \n"
        echo -e "\nNOTE: Ensure all containers you wish to keep are running interactively."
        echo -e "\nNOTE: This operation will not affect named \(tagged\) images." 
	} 

	# check whether user had supplied -h or --help . If yes display usage 
	if [[ ( $@ == "--help") ||  $@ == "-h" ]] 
	then 
		display_usage
		exit 0
	fi 

#Docker cleanup fuction
dcleanup(){
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

echo -e "\n\033[31m\033[1m Removing containers not attached to shells, and image layers not related to tagged images.\033[0m\n"

dcleanup
