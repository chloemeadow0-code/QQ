FROM mlikiowa/napcat-docker:latest

# 先解压官方包，获取 node_modules（express等依赖）
RUN cd /app && unzip -qo NapCat.Shell.zip -d ./NapCat.Shell && \
    cp -rf NapCat.Shell/* napcat/ && \
    rm -rf ./NapCat.Shell

# 再覆盖二改文件
COPY packages/napcat-shell/dist/napcat.mjs /app/napcat/napcat.mjs
COPY packages/napcat-shell/dist/static /app/napcat/static/
COPY packages/napcat-shell/dist/worker /app/napcat/worker/
