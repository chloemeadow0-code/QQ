FROM mlikiowa/napcat-docker:latest

# 只覆盖二改的代码和前端，不动基础镜像的 node_modules 和 package.json
COPY packages/napcat-shell/dist/napcat.mjs /app/napcat/napcat.mjs
COPY packages/napcat-shell/dist/static /app/napcat/static/
COPY packages/napcat-shell/dist/config /app/napcat/config/
COPY packages/napcat-shell/dist/worker /app/napcat/worker/
