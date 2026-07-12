FROM n8nio/n8n:latest

ENV N8N_PORT=7860
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV N8N_USER_FOLDER=/data
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

USER root

# Install Chromium + the libs it needs to run headless on Alpine
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Tell Puppeteer to use the system Chromium instead of downloading its own
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install the community Puppeteer node into n8n's custom nodes folder
RUN mkdir -p /data/.n8n/custom \
    && cd /data/.n8n/custom \
    && npm init -y \
    && npm install n8n-nodes-puppeteer \
    && chown -R node:node /data

RUN mkdir -p /data && chown -R node:node /data
USER node

COPY --chown=node:node workflows/initial-workflow.json /home/node/initial-workflow.json

EXPOSE 7860