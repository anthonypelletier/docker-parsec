FROM ubuntu:18.04

MAINTAINER Anthony PELLETIER <contact@anthonypelletier.fr>

RUN apt-get update && \
	apt-get install -y \
	libcairo2 \
	libfreetype6 \
	libgdk-pixbuf2.0-0 \
	libgl1 \
	libgl1-mesa-glx \
	libglib2.0-0 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libpangocairo-1.0-0 \
	libsm6 \
	libsndio6.1 \
	libx11-6 \
	libxxf86vm1 \
	pulseaudio \
	libva2 \
	libva-glx2 \
	libva-x11-2 \
	libva-wayland2 \
	libva-drm2

ADD https://s3.amazonaws.com/parsec-build/package/parsec-linux.deb parsec-linux.deb

RUN dpkg -i parsec-linux.deb && \
	rm parsec-linux.deb

RUN cp /usr/lib/x86_64-linux-gnu/libva* /usr/lib/x86_64-linux-gnu/dri

RUN groupadd --gid 1000 parsec && \
	useradd --gid 1000 --uid 1000 -m parsec && \
	usermod -aG video parsec

ADD ./rootfs/ /

RUN chown parsec:parsec /home/parsec/.parsec

USER parsec

CMD /usr/bin/parsecd