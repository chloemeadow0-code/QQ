FROM mlikiowa/napcat-docker:latest

# 二改文件放到临时目录，不触发 entrypoint 的检测
COPY packages/napcat-shell/dist/napcat.mjs /tmp/overlay/napcat.mjs
COPY packages/napcat-shell/dist/static/ /tmp/overlay/static/
COPY packages/napcat-shell/dist/worker/ /tmp/overlay/worker/

# 在 entrypoint 的 "cd /app/napcat" 前面插入覆盖命令
# 这样 entrypoint 会先正常解压 zip（node_modules 有了），再覆盖二改文件
RUN sed -i '/^cd \/app\/napcat$/i cp -rf /tmp/overlay/. /app/napcat/' /app/entrypoint.sh
