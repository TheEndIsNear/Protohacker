FROM elixir:1.14.3-alpine as build

RUN mkdir /app
WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs ./
RUN mix deps.get --only $MIX_ENV
RUN mix do deps.compile

COPY lib lib

RUN mix compile

RUN mix release

FROM elixir:1.14.3-alpine AS app

RUN apk add --update bash

RUN mkdir /app
WORKDIR /app
ENV MIX_ENV=prod

COPY --from=build /app/_build/prod/rel/echo_server .

COPY entrypoint.sh .
RUN chown -R nobody: /app
USER nobody

EXPOSE 8080

ENV HOME=/app

CMD ["bash", "/app/entrypoint.sh"]

