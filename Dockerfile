FROM adoptopenjdk/openjdk8:alpine
LABEL maintainer="Diogo Oliveira <diogo0liveira@hotmail.com>"

RUN apk add --no-cache \
	bash \
	unzip && \
	apk add ca-certificates && \
	apk add --virtual .rundeps $runDeps && \
	update-ca-certificates && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

ENV ANDROID_SDK_ROOT "/opt/sdk"
ENV PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools

COPY debug.keystore /

RUN mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && mv debug.keystore ~/.android/
RUN mkdir -p ${ANDROID_SDK_ROOT}

RUN wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O /tmp/tools.zip && \
	unzip -qq /tmp/tools.zip -d ${ANDROID_SDK_ROOT} && \
	rm -v /tmp/tools.zip

RUN yes | \
	${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "--licenses" && \
	${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --verbose "platforms;android-29" && \
	${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --verbose "build-tools;30.0.1" && \
	${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --verbose "platform-tools" && \ 
	${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --verbose "--update"
