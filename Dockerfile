FROM node:22-slim
WORKDIR /app
COPY packages/napcat-shell/dist /app/napcat/
WORKDIR /app/napcat
RUN npm install --production
WORKDIR /app
COPY packages/napcat-webui-backend/webui.json /app/napcat/config/webui.json
RUN mkdir -p /app/.config/QQ
VOLUME /app/napcat/config
VOLUME /app/.config/QQ
EXPOSE 6099
ENTRYPOINT ["node", "/app/napcat/napcat.mjs"]
