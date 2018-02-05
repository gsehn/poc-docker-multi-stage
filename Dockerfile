FROM node:slim as builder
WORKDIR /opt/app
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
COPY index.js package.json yarn.lock ./
RUN yarn install --frozen-lockfile
RUN yarn run build

FROM alpine:latest as runner
WORKDIR /opt/app
RUN apk update && apk add --no-cache libstdc++ libgcc
COPY --from=builder /opt/app/dist/hello-world ./
CMD ./hello-world
