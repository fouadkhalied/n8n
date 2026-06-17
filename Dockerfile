# Use the official n8n image
FROM n8nio/n8n:latest

# Environment variables for Hugging Face and Security
ENV N8N_PORT=7860
ENV N8N_LISTEN_ADDRESS=0.0.0.0

# Persistence settings for Hugging Face
# HF Spaces use /data for persistent storage if you enable a volume
ENV N8N_USER_FOLDER=/data
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Fix permissions for /data
USER root
RUN mkdir -p /data && chown -R node:node /data
USER node

# Pre-load the workflow placeholder (user can import it manually or via CLI)
COPY --chown=node:node workflows/initial-workflow.json /home/node/initial-workflow.json

# Ensure n8n is in path
ENV PATH=$PATH:/home/node/.npm-global/bin:/usr/local/bin

EXPOSE 7860

# Use full path to avoid 'command not found' errors on some platforms
CMD ["n8n", "start"]
