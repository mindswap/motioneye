FROM ubuntu:16.04
MAINTAINER MindSwap <mindswap@ro.ru>

RUN	apt-get update && \
	apt-get install -q -y \
	motion \
	ffmpeg \
	v4l-utils \
	python-pip \
	python-dev \
	curl \
	libssl-dev \
	libcurl4-openssl-dev \
	libjpeg-dev && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
		
RUN	pip install --upgrade pip && \
	pip install motioneye
	
RUN	mkdir -p /etc/motioneye  && \
	cp /usr/local/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf && \
	mkdir -p /var/lib/motioneye && \
	cp /usr/local/share/motioneye/extra/motioneye.init-debian /etc/init.d/motioneye && \
	chmod +x /etc/init.d/motioneye

RUN	update-rc.d -f motioneye defaults && \
	/etc/init.d/motioneye start
	
EXPOSE 8765	

VOLUME ["/var/lib/motioneye", "/etc/motioneye"]
