#FROM ubuntu:12.04
FROM debian:sid

MAINTAINER Phusion <info@phusion.nl>

ENV HOME /root
RUN mkdir /build
ADD . /build

RUN /build/prepare.sh && \
	/build/system_services.sh && \
	/build/utilities.sh && \
	/build/cleanup.sh

ENV LC_ALL C.UTF-8

CMD ["/sbin/my_init"]
