FROM n8nio/n8n:latest

USER root

# Install only necessary dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    git

# Create directories and set permissions
RUN mkdir -p /home/node/.n8n/nodes && \
    mkdir -p /home/node/.n8n/custom && \
    chown -R node:node /home/node/.n8n && \
    chmod -R 755 /home/node/.n8n

# Set NPM configuration
RUN npm config set unsafe-perm true

# Switch to node user
USER node

# Set environment variables with memory configuration
ENV NODE_OPTIONS="--max-old-space-size=2048"
ENV N8N_CUSTOM_EXTENSIONS="/home/node/.n8n/custom"
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true
ENV N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
ENV N8N_UNVERIFIED_PACKAGES_ENABLED=true
ENV N8N_VERIFIED_PACKAGES_ENABLED=true
ENV NODE_FUNCTION_ALLOW_EXTERNAL="*"
ENV NPM_CONFIG_PREFIX=/home/node/.n8n
ENV N8N_METRICS=false
ENV N8N_LOG_LEVEL=error

WORKDIR /home/node/.n8n

EXPOSE 5678

CMD ["n8n", "start"]
