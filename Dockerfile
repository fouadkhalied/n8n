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
RUN mkdir -p /data && chown -R 1000:1000 /data
USER 1000

# Pre-load the workflow placeholder (user can import it manually or via CLI)
COPY --chown=1000:1000 workflows/initial-workflow.json /home/node/initial-workflow.json

EXPOSE 7860

CMD ["n8n", "start"]
