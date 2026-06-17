FROM n8nio/n8n:latest

ENV N8N_PORT=7860
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV N8N_USER_FOLDER=/data
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

USER root
RUN mkdir -p /data && chown -R node:node /data
USER node

COPY --chown=node:node workflows/initial-workflow.json /home/node/initial-workflow.json

EXPOSE 7860