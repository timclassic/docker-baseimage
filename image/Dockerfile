
# Build with : docker build -t=YOURUSER/baseimage-docker-debian:7.4 .

#FROM ubuntu:12.04
FROM debian:7.4

MAINTAINER Tim Stewart <tim@stoo.org>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
	/build/cleanup.sh

ENV LC_ALL C.UTF-8

CMD ["/sbin/my_init"]
