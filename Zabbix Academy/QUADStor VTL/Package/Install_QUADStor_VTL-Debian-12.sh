#!/bin/bash

# Instalação do QUADStor VTL no Debian 12 LTS
# Autor: Magno M Cerqueira 
# Testado em: Debian 12.11.0 LTS (x86_64)

set -e

echo "▶️ Atualizando pacotes do sistema..."
apt-get update && apt-get upgrade -y

echo "▶️ Instalando dependências..."
apt-get install -y \
  uuid-runtime \
  build-essential \
  sg3-utils \
  apache2 \
  psmisc \
  firmware-qlogic \
  linux-headers-$(uname -r) \
  wget \
  sudo 

echo "▶️ Ativando o módulo CGI do Apache..."
sudo a2enmod cgi
sudo systemctl restart apache2

echo "▶️ Baixando o pacote QUADStor VTL (.deb)..."
cd /tmp
wget -O quadstor-vtl.deb "https://github.com/MagnoMonteCerqueira/ProBix/raw/main/Zabbix%20Academy/QUADStor%20VTL/Package/quadstor-vtl-std-3.0.79.26-debian12-x86_64.deb"

echo "▶️ Instalando o pacote QUADStor VTL..."
sudo dpkg -i quadstor-vtl.deb || sudo apt-get install -f -y

echo "▶️ Iniciando serviços do QUADStor..."
sudo systemctl restart apache2

echo "✅ Instalação concluída!"
echo "🌐 Acesse a interface web via: http://$(hostname -I | awk '{print $1}')"
echo "🔐 Usuário padrão: admin | Senha: admin"
