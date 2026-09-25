ARG CADDY_VERSION

FROM caddy:${CADDY_VERSION}-builder AS builder

ARG CADDY_VERSION
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build v${CADDY_VERSION#v} \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
