#!/bin/bash

echo "Bem-vindo ao Script de Instalação do Servidor Web"
echo "Esse script irá instalar o Apache e configurar uma página inicial"
read -p "Deseja continuar? (s/n): " confirm

if [ "$confirm" != "s" ]; then
    echo "Instalação abortada pelo usuário."
    exit 1
fi

echo "Atualizando pacotes do sistema..."
sudo apt update -y

echo "Instalando o servidor Apache..."
sudo apt install apache2 -y

if [ $? -eq 0 ]; then
    echo "Apache instalado com sucesso!"
else
    echo "Erro na instalação do Apache."
    exit 1
fi

echo "Baixando template HTML..."
cd /tmp
git clone https://github.com/adrianbautista/html-css-template.git

echo "Publicando template HTML..."
sudo cp -r /tmp/html-css-template/* /var/www/html/

echo "Reiniciando o Apache..."
sudo systemctl restart apache2

echo "Processo concluído. Acesse o servidor para ver o template em ação!"
