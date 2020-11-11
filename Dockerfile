# UBUNTU slim but not sveldt (385MB)
FROM ubuntu:20.04 
RUN apt-get update && apt-get upgrade -y
ENV INSTALL="apt-get install -y"
RUN $INSTALL ripgrep
RUN $INSTALL sudo
RUN $INSTALL curl
RUN $INSTALL nodejs
RUN $INSTALL ffmpeg
RUN $INSTALL git

RUN echo "unroot    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd unroot -s /bin/bash -m 
RUN usermod -aG sudo unroot
LABEL maintainer="karl@oyamist.com"

# Application setup
#COPY src /home/unroot/src
#COPY scripts /home/unroot/scripts
#COPY index.js /home/unroot/index.js

# Copy selected node_modules without their .git folders
#COPY node_modules/log-instance /home/unroot/node_modules/log-instance
#COPY node_modules/json5 /home/unroot/node_modules/json5
#COPY node_modules/js-ebt /home/unroot/node_modules/js-ebt
#COPY node_modules/memo-again /home/unroot/node_modules/memo-again
#COPY node_modules/merkle-json /home/unroot/node_modules/merkle-json
#COPY node_modules/suttacentral-api /home/unroot/node_modules/suttacentral-api
#COPY node_modules/express /home/unroot/node_modules/express

# Caches are about 200MB without the huge .git folders
#COPY local/sounds /home/unroot/local/sounds

# Finalize
RUN chown -R unroot:unroot /home/unroot
#RUN /home/unroot/scripts/js/prune-stubs.js rm
CMD [ "bash", "-c", "su -l unroot" ]
