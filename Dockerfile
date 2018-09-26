FROM alpine:edge
MAINTAINER Koki Takahashi <hakatasiloving@gmail.com>

RUN apk add libgcc libstdc++ py2-yaml python2 libtool perl automake autoconf npm git bash build-base && \
	cd /tmp && \
	git clone https://github.com/neonious/lowjs.git --depth 1 && \
	cd lowjs && \
	git submodule update --init --recursive && \
	make && \
	cp lib/* /lib -r && \
	cp bin/* /bin -r && \
	cd /root && \
	apk del py2-yaml python2 libtool perl automake autoconf npm git bash build-base && \
	rm -rf /var/cache/apk/* /tmp/* /root/.npm && \
	ln -s /bin/low /bin/node

WORKDIR /root

CMD [ "low" ]