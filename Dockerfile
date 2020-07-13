FROM diogo0liveira/android-29-alpine-slim:latest
LABEL maintainer="Diogo Oliveira <diogo0liveira@hotmail.com>"


RUN apk add --update --no-cache \
	git && \
	apk add python3 py-pip && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

RUN pip install semversioner==0.8.1
