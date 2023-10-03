FROM --platform=linux/amd64 node:18-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json yarn.lock ./
RUN yarn install
# RUN yarn add --platform=linuxmusl --arch=arm64v8 sharp
# RUN SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm_config_arch=x64 npm_config_platform=linux yarn add sharp@0.32.1
ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . .
RUN chown -R node:node /opt/app
USER node
RUN yarn build
EXPOSE 1337
CMD ["yarn", "develop"]