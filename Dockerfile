FROM alpine:edge AS builder

ARG APP_NAME
ARG APP_VERSION
ARG MIX_ENV=prod

ENV APP_NAME=${APP_NAME} \
    APP_VERSION=${APP_VERSION} \
    MIX_ENV=${MIX_ENV}

WORKDIR /tmp

# install build tools
RUN apk add git elixir erlang-runtime-tools \
 && mix local.rebar --force \
 && mix local.hex --force

# copy source code into the build container
COPY . .

# assemble release to /tmp/built
RUN mix do deps.get, clean, compile \
 && mkdir -p /tmp/built \
 && mix release --verbose \
 && cp _build/${MIX_ENV}/rel/${APP_NAME}/releases/${APP_VERSION}/${APP_NAME}.tar.gz /tmp/built \
 && cd /tmp/built \
 && tar -xzf ${APP_NAME}.tar.gz \
 && rm ${APP_NAME}.tar.gz

# release docker image
FROM alpine:edge

ARG APP_NAME
ARG PORT

RUN apk add bash libcrypto1.1

ENV REPLACE_OS_VARS=true \
    APP_NAME=${APP_NAME} \
    PORT=${PORT:-"4000"}

WORKDIR /app

COPY --from=builder /tmp/built .

EXPOSE $PORT

CMD trap 'exit' INT; /app/bin/${APP_NAME} foreground
