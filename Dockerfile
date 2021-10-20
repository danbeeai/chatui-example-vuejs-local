# base image ubuntu
FROM ubuntu:16.04

LABEL Name="chatui-example-vuejs-local Version=0.0.1"
LABEL maintainer="Donny Seo <jams7777@gmail.com>"

# Install wget and install/updates certificates node
RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates bzip2 apt-transport-https \
						vim curl ssh git nodejs \
	&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
	&& apt-get install -y nodejs \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && apt-get update && apt-get install yarn && rm -rf /var/lib/apt/lists/*

ENV NPM_CONFIG_LOGLEVEL warn
ENV NODE_VERSION 8.12.0

# work dir make
RUN mkdir /app
RUN chmod 777 -R /app
RUN mkdir /app/web
RUN chmod 777 -R /app/web
RUN mkdir /app/web2
RUN chmod 777 -R /app/web2

# Install npm lastest
RUN /usr/bin/npm install -g npm@6.14.5 
RUN /usr/bin/npm install -g vue-cli@2.9.6
RUN echo 'npm vue-cli install' > /root/.bowerrc

# package copy
COPY ./package.json /app/web2/package.json

# node_module root
RUN cd /app/web2 && npm install --save-dev

# homepage root
WORKDIR /app/web

# exec shell setting
COPY ./start.sh /root/start.sh
RUN chmod 777 /root/start.sh

# alais setting
RUN  echo "alias app='cd /app/web'" >> /root/.bashrc
RUN  echo "alias start='/root/start.sh'" >> /root/.bashrc

RUN  echo "echo " >> /root/.bashrc
RUN  echo "echo " >> /root/.bashrc
RUN  echo "echo ' ************  Danbee.Ai Chatui Example Vuejs [ local ]     ************* ' " >> /root/.bashrc
RUN  echo "echo ' *****                                                            ******* ' " >> /root/.bashrc
RUN  echo "echo ' ***** << Alias >>                                                ******* ' " >> /root/.bashrc
RUN  echo "echo ' *****       app : frogue Server app                              ******* ' " >> /root/.bashrc
RUN  echo "echo ' *****     start : start dev nuxt server                          ******* ' " >> /root/.bashrc
RUN  echo "echo ' ************************************************************************ ' " >> /root/.bashrc

# Volume setting
VOLUME ["/app/web"]

# Port setting
EXPOSE 8080

CMD ["/bin/bash"]
