FROM mlikiowa/napcat-docker:latest

# 构建时直接解压官方 zip，拿到完整的 node_modules（express等依赖）
RUN cd /app && unzip -qo NapCat.Shell.zip -d napcat_temp && \
    cp -rf napcat_temp/* napcat/ && \
    rm -rf napcat_temp

# 再覆盖二改文件（napcat.mjs、static、worker）
COPY packages/napcat-shell/dist/napcat.mjs /app/napcat/napcat.mjs
COPY packages/napcat-shell/dist/static/ /app/napcat/static/
COPY packages/napcat-shell/dist/worker/ /app/napcat/worker/
