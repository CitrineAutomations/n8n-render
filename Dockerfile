# Based on official n8n-io/self-hosted-ai-starter-kit
# Updated for n8n 2.0+ compatibility
# Security: Using version 1.111.0+ to address CVE-2025-68668

FROM n8nio/n8n:latest

# Set working directory
WORKDIR /home/node

# Create necessary directories with proper permissions
USER root
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Switch back to node user
USER node

# Expose n8n port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n"]

