FROM --platform=linux/amd64 node:18-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache openssh-client build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
# RUN mkdir /root/.ssh && chmod 700 /root/.ssh
# && ssh-keyscan -t rsa bitbucket.org >> /root/.ssh/known_hosts
# && ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
# RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
# RUN chown -R ${USER} /root/.ssh/known_hosts


WORKDIR /opt/
COPY package.json yarn.lock ./
RUN yarn global add node-gyp
RUN yarn install
ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN ls -l /opt/app
RUN yarn build
RUN chown -R node:node /opt/app
USER node
EXPOSE 1337
CMD ["yarn", "develop"]