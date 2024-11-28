#!/bin/bash
RED='\033[1;31m'
BLACK='\033[0;30m'
DARK_GRAY='\033[1;30m'
LIGHT_RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
BROWN_ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GRAY='\033[0;37m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
echo -e "${LIGHT_BLUE}Criando certificado para o Grafana...${NC}"
rm -rf *.pem
rm -rf *.jks
rm -rf *.der

export OPENSSL_CN="grafana.local"
export OPENSSL_IP_ADDRESS="192.168.0.160"
export OPENSSL_C=BR
export OPENSSL_ST=SaoPaulo
export OPENSSL_L=SaoPaulo
export OPENSSL_O=MinhaEmpresa
export OPENSSL_OU=TI
export OPENSSL_PASS=123456

# Analisando os argumentos
while getopts ":d:i:s:h" opt; do
  case $opt in
    d)
      OPENSSL_CN="$OPTARG"
      ;;
    i)
      OPENSSL_IP_ADDRESS="$OPTARG"
      ;;
    s)
      OPENSSL_PASS="$OPTARG"
      ;;
    h)
      echo "Uso: $0 [-d domínio] [-i ip do docker] [-s senha do certifdicado]"
      exit 0
      ;;
    \?)
      echo "Opção inválida: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Opção -$OPTARG requer um argumento." >&2
      exit 1
      ;;
  esac
done


sudo openssl genrsa -out ../etc/grafana/grafana.key 2048
sudo openssl req -new -key ../etc/grafana/grafana.key -out ../etc/grafana/grafana.csr -subj "/C=${OPENSSL_C}/ST=${OPENSSL_ST}/L=${OPENSSL_L}/O=${OPENSSL_O}/OU=${OPENSSL_OU}/CN=${OPENSSL_CN}" -passin pass:${OPENSSL_PASS} -passout pass:${OPENSSL_PASS}
sudo openssl x509 -req -days 5000 -in ../etc/grafana/grafana.csr -signkey ../etc/grafana/grafana.key -out ../etc/grafana/grafana.crt

# sudo chown grafana:grafana ./etc/grafana/grafana.crt
# sudo chown grafana:grafana ./etc/grafana/grafana.key
sudo chmod 400 ../etc/grafana/grafana.key ../etc/grafana/grafana.crt

rm -rf *.pem
rm -rf *.der
rm -rf *.pfx
rm -rf *.csr
rm -rf *.srl