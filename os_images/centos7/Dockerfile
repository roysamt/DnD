FROM centos:7

## Set up dockerized baseline development environment in RHEL CentOS 7

MAINTAINER Tejas Roysam "roysamt@github"

## Development package installations ##
# sublime text   - Text editor
# xauth          - X server connection
# xterm          - xterminal emulator
# tkinter.x86-64 - Python GUIs
# net-tools      - Ifconfig
# gitk           - GitK GUI for convenience
## ################################# ##
RUN rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg                                \
    && yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo \
    && yum install -y sublime-text                                                                        \
    && yum install -y sudo xauth xterm tkinter.x86_64                                                     \
    && yum install -y net-tools                                                                           \
    && yum install -y gitk                                                                                \
    && echo "Installations complete"

##            Sublime setup               ##
# dejavu fonts - default sublime monospace fonts
# configure locale to en_US
## ###################################### ##
RUN yum install -y dejavu-fonts-common                                                                       \
    && yum install -y dejavu-lgc-sans-mono-fonts.noarch                                                      \
    && localedef -i en_US -f UTF-8 en_US.UTF-8

##  Development Environment Initialization ##
#
## ####################################### ##
RUN mkdir dev_workspace                                                                                  \
    && echo -e "\nFuture actions TBD\n"

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]