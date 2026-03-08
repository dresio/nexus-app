# Nexus Server — lightweight runtime image
# Uses a pre-built binary from the CI release pipeline.
#
# Build:
#   docker build --build-arg NEXUS_BIN=./nexus-server-linux-amd64 -t nexus-server .
#
# Or with docker compose:
#   Place the release binary as ./nexus-server-linux-amd64 and run:
#   docker compose up -d

FROM debian:bookworm-slim

# Install minimal runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd --system --create-home --home-dir /var/lib/nexus --shell /bin/false nexus

# Copy pre-built binary
ARG NEXUS_BIN=nexus-server-linux-amd64
COPY ${NEXUS_BIN} /usr/local/bin/nexus-server
RUN chmod +x /usr/local/bin/nexus-server

# Create data directory (mount point for persistent storage)
RUN mkdir -p /var/lib/nexus/data && \
    chown -R nexus:nexus /var/lib/nexus

USER nexus
WORKDIR /var/lib/nexus

# TCP: HTTP/WS (default 8443)
EXPOSE 8443
# UDP: Voice chat (configurable via NEXUS_VOICE_PORT)
EXPOSE 10000/udp

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -fsk https://localhost:${NEXUS_PORT:-8443}/api/stats || \
        curl -fs  http://localhost:${NEXUS_PORT:-8443}/api/stats || exit 1

CMD ["nexus-server"]
