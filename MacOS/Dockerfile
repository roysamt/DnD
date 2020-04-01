FROM js-er-code.jsc.nasa.gov:5005/xemu/plss_cws_image_centos7_base:latest

## Set up dockerized baseline PLSS development environment for MacOS

## Command line build_args (passed to docker build command ##
ARG U_NAME=unsetName
ARG U_EMAIL=unsetEmail

## PLSS Development package installations ##
# sublime text   - Text editor
# xauth          - X server connection
# xterm          - PLSS Sim xterminal emulator
# tkinter.x86-64 - PLSS Sim GUIs
# net-tools      - Ifconfig
# gitk           - GitK GUI for convenience
## ###################################### ##
RUN rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg                                \
    && yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo \
    && yum install -y sublime-text                                                                        \
    && yum install -y sudo xauth xterm tkinter.x86_64                                                     \
    && yum install -y net-tools                                                                           \
    && yum install -y gitk                                                                                \
    && echo "Installations complete"

## Sublime setup ##
# dejavu fonts - default sublime monospace fonts
# configure locale to en_US
## ###################################### ##
RUN yum install -y dejavu-fonts-common                                                                       \
    && yum install -y dejavu-lgc-sans-mono-fonts.noarch                                                      \
    && localedef -i en_US -f UTF-8 en_US.UTF-8

## PLSS Development Environment Initialization ##
#
## ########################################### ##
RUN mkdir xemu_workspace                                                                                  \
    && cd xemu_workspace                                                                                  \
    && git clone https://js-er-code.jsc.nasa.gov/xemu/plss_cws_mission.git                                \
    && cd plss_cws_mission/                                                                               \
    && git config --global user.email $U_EMAIL                                                            \
    && git config --global user.name $U_NAME                                                              \
    && echo -e "\n\nSet git email as ${U_EMAIL} and name as ${U_NAME}\n"                                  \ 
    && echo -e "\n\n"

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/bin/bash"]
