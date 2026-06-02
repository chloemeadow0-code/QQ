FROM mlikiowa/napcat-docker:latest

# 把二改文件放到临时目录（不影响 entrypoint 的检测逻辑）
COPY packages/napcat-shell/dist/napcat.mjs /tmp/custom/napcat.mjs
COPY packages/napcat-shell/dist/static/ /tmp/custom/static/
COPY packages/napcat-shell/dist/worker/ /tmp/custom/worker/

# 关键！修改 loadNapCat.js：
# 1. entrypoint 会正常解压 zip（node_modules 有了）
# 2. QQ 启动时加载这个文件
# 3. 先用 cp 覆盖二改文件，再 import napcat.mjs
# 这样 express 从官方解压的 node_modules 里就能找到了
RUN cat > /opt/QQ/resources/app/loadNapCat.js << 'JSEOF'
(async () => {
  const { execSync } = await import('node:child_process');
  const { existsSync } = await import('node:fs');
  if (existsSync('/tmp/custom/napcat.mjs')) {
    execSync('cp -rf /tmp/custom/* /app/napcat/');
  }
  await import('file:///app/napcat/napcat.mjs');
})();
JSEOF
