# Pin to n8n 1.123.4 (current version)
# To upgrade to 2.0, change to: n8nio/n8n:2.0.0 or n8nio/n8n:stable (if 2.0 is stable)
FROM n8nio/n8n:1.123.4

USER root

# Install only necessary dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    git

# Create directories and set permissions
# Note: Removed invalid npm config line that was causing build failures
RUN mkdir -p /home/node/.n8n/nodes && \
    mkdir -p /home/node/.n8n/custom && \
    chown -R node:node /home/node/.n8n && \
    chmod -R 755 /home/node/.n8n

# Switch to node user
USER node

# Pre-install required community packages to ensure they're available on startup
# This prevents "Unrecognized node type" errors
# Cache bust: Add timestamp to force rebuild when packages need updating
ARG CACHE_BUST=1
RUN echo "=== Installing community packages (cache bust: $CACHE_BUST) ===" && \
    cd /home/node/.n8n && \
    echo '{"name":"n8n-community-packages","version":"1.0.0"}' > package.json && \
    echo "Installing @n8n/n8n-nodes-langchain..." && \
    npm install @n8n/n8n-nodes-langchain@latest --save --legacy-peer-deps --no-audit --no-fund && \
    echo "Installing n8n-nodes-attio..." && \
    npm install n8n-nodes-attio@latest --save --legacy-peer-deps --no-audit --no-fund && \
    echo "=== Verifying installation ===" && \
    ls -la node_modules/ | grep -E "(langchain|attio)" && \
    echo "=== Community packages installation completed ==="

# Set environment variables with memory configuration
ENV NODE_OPTIONS="--max-old-space-size=2048"
ENV N8N_CUSTOM_EXTENSIONS="/home/node/.n8n/custom"
ENV N8N_COMMUNITY_PACKAGES_ENABLED=true
ENV N8N_COMMUNITY_PACKAGES_ALLOW_TOOL_USAGE=true
ENV N8N_UNVERIFIED_PACKAGES_ENABLED=true
ENV N8N_VERIFIED_PACKAGES_ENABLED=true
ENV NODE_FUNCTION_ALLOW_EXTERNAL="*"
ENV N8N_METRICS=false
ENV N8N_LOG_LEVEL=debug
ENV N8N_REINSTALL_MISSING_PACKAGES=true
ENV N8N_TRUSTED_PROXY_IPS="*"
ENV DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false
# Ensure community packages are installed in the correct location
ENV N8N_USER_FOLDER=/home/node/.n8n
# NPM config prefix needed for community package installation
ENV NPM_CONFIG_PREFIX=/home/node/.n8n

WORKDIR /home/node/.n8n

EXPOSE 5678

CMD ["n8n", "start"]
