FROM alpine:edge
MAINTAINER Koki Takahashi <hakatasiloving@gmail.com>

RUN apk add libgcc libstdc++ py2-yaml python2 libtool perl automake autoconf npm git bash build-base && \
	cd /tmp && \
	git clone https://github.com/neonious/lowjs.git --depth 1 && \
	cd lowjs && \
	(git submodule update --init --depth 1 --recursive || echo "Ignoring submodule update failure") && \
	cd deps/duktape && \
	git checkout -- && \
	cd ../.. && \
	make && \
	cp lib/* /lib -r && \
	cp bin/* /bin -r && \
	cd /root && \
	apk del py2-yaml python2 libtool perl automake autoconf npm git bash build-base && \
	rm -rf /var/cache/apk/* /tmp/* /root/.npm

WORKDIR /root

CMD [ "sh" ]