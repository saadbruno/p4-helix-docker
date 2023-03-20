FROM ubuntu:lunar

RUN apt-get update

# we need wget to download perforce files
RUN apt-get install -y wget

# creates necessary dirs
RUN mkdir -p /perforce/server
RUN mkdir -p /perforce/bin
RUN mkdir -p /perforce/ssl

# ssl directory must be readable only by the current user
RUN chmod 700 /perforce/ssl

# download and extract perforce files
WORKDIR /perforce/bin/
RUN wget https://www.perforce.com/downloads/perforce/r22.2/bin.linux26x86_64/helix-core-server.tgz
RUN tar -xzf helix-core-server.tgz
RUN rm helix-core-server.tgz

# perforce executables already come with the x flag, but let's set it just to be sure
RUN chmod u+x p4 p4broker p4d p4p 

COPY entrypoint.sh ./
RUN chmod u+x entrypoint.sh

# lets set the required environment variables
ENV P4SSLDIR=/perforce/ssl
ENV P4USER=perforce
ENV P4PORT=ssl:localhost:1666

EXPOSE 1666

# runs the entrypoint script
ENTRYPOINT /perforce/bin/entrypoint.sh