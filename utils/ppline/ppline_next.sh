#!/bin/bash


#Se for usar um SSM
#export PATH=/root/.nvm/versions/node/v20.11.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Configurações
PORTA="3010"
ROOT_DIR="/var/www/html/homologs"
REPO_ORIGINAL=$(ls -d /var/www/html/homologs/jornalOficinaBrasil_* | sort -r | head -n 1)
REPO_ORIGINAL_PIPE="$REPO_ORIGINAL"
APP_NAME="oficina-homolog"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
DEPLOY_DIR="${ROOT_DIR}/jornalOficinaBrasil_$TIMESTAMP"

echo "=== Iniciando Deploy em $(date) ==="

# 1. Git pull no repositório original
cd "$REPO_ORIGINAL"
echo ">> Dando git pull"
git pull

# 2. Copiar para nova pasta com timestamp
echo ">> Criando nova pasta: $DEPLOY_DIR"
cp -r "$REPO_ORIGINAL_PIPE" "$DEPLOY_DIR"

# 3. Build
cd "$DEPLOY_DIR"
echo ">> Instalando dependências"
npm install

echo ">> Rodando build"
if ! NODE_OPTIONS="--max-old-space-size=4096" npm run build; then
    echo "!! Build falhou. Abortando."
    rm -rf "$DEPLOY_DIR"
    exit 1
fi

# 4. Parar app anterior no PM2
echo ">> Deletando instância antiga do PM2: $APP_NAME"
pm2 delete "$APP_NAME" || echo ">> PM2 não tinha instância ativa com nome $APP_NAME"

# 5. Iniciar novo build com PM2
cd "$DEPLOY_DIR"
echo ">> Iniciando nova instância PM2 apontando para $DEPLOY_DIR"
PORT="$PORTA" pm2 start npm --name "$APP_NAME" -- start

# 6. Remover todas as versões anteriores
echo ">> Apagando todas as versões antigas"
rm -rf "$REPO_ORIGINAL_PIPE"

echo "=== Deploy finalizado com sucesso ==="