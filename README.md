# p4-helix-docker
My image for my local perforce server. Feel free to use it for whatever.

This server is running in Unicode, and with SSL (certs are generated on first start up).

This image is published to the Docker Hub. If you don't wanna clone this repo and build the image, you can just run with this simple compose file:
```yml
version: '3.5'
services:
  perforce_helix:
    image: saadbruno/p4-helix-docker
    container_name: perforce_helix
    volumes:
        - './data:/perforce/server'
        - './ssl:/perforce/ssl'
    ports:
        - '1666:1666'
    restart: always
    logging:
        options:
            max-size: 10m
```
