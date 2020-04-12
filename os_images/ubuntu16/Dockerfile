FROM ubuntu:16.04

## Set up dockerized baseline development environment in Debian Ubuntu 16.04

MAINTAINER Tejas Roysam "roysamt@github"

#Resolvconf fix
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

#Manually update apt and install apt-utils before adding packages
RUN apt-get -y update && apt-get -y install -y --no-install-recommends apt-utils

## Development package installations ##
RUN apt-get -y install htop               																			  \
	&& apt-get -y install vim             																			  \
	&& apt-get -y install build-essential 																			  \
	&& apt-get -y install curl			  																		      \
	&& apt-get -y install python3         																			  \
	&& apt-get -y install git                    																	  \
	&& wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -                                  \
	&& echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list       \
	&& apt-get -y update && apt-get instal sublime-text																  \
    && ap-get -y install sudo																						  \
    && echo "Installations complete"

##  Development Environment Initialization ##
#
## ####################################### ##
RUN mkdir dev_workspace                                                                                  			  \
    && echo -e "\nFuture actions TBD\n"

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]