FROM n8nio/n8n:latest

USER root

# Install build dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    gcc \
    g++ \
    make \
    musl-dev \
    linux-headers \
    python3-dev \
    git \
    nodejs \
    npm

# Create directories and set permissions
RUN mkdir -p /home/node/.n8n/nodes && \
    mkdir -p /home/node/.n8n/custom && \
    chown -R node:node /home/node/.n8n && \
    chmod -R 755 /home/node/.n8n

# Switch to node user
USER node

# Set the custom nodes directory
ENV N8N_CUSTOM_EXTENSIONS="/home/node/.n8n/custom"

EXPOSE 5678

CMD ["n8n", "start"]
