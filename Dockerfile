# n8n 2.0: Use stable tag (will auto-update to latest 2.0.x)
# For production, consider pinning to specific version (e.g., 2.0.0, 2.0.1)
# Note: Task runners are no longer included in n8nio/n8n image
# If using Python Code nodes, you'll need to set up external task runners with n8nio/runners image
FROM n8nio/n8n:stable

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
ENV N8N_LOG_LEVEL=info
ENV N8N_REINSTALL_MISSING_PACKAGES=true
ENV N8N_TRUSTED_PROXY_IPS="*"
ENV DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

WORKDIR /home/node/.n8n

EXPOSE 5678

CMD ["n8n", "start"]
