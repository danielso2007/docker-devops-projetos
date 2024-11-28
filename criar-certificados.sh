#/usr/bin/bash
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
echo -e "${LIGHT_BLUE}Criando credenciais...${NC}"
cd nexus/ssl
./criar_jks_nexus.sh
cd ..
cd ..
cd jenkins/ssl
./criar_jks_jenkins.sh
cd ..
cd ..
cd grafana/ssl
./criar_ssl-grafana.sh
cd ..
cd ..
cd sonar/ssl
./criar_jks_sonar.sh
cd ..
cd ..
cd rancher/ssl
./criar_jks_rancher.sh
cd ..
cd ..
data_path="./nginx/certbot"
if [ ! -e "$data_path/conf/options-ssl-nginx.conf" ] || [ ! -e "$data_path/conf/ssl-dhparams.pem" ]; then
  echo -e "${LIGHT_BLUE}Downloading recommended TLS parameters...${NC}"
  mkdir -p "$data_path"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/options-ssl-nginx.conf"
  curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/ssl-dhparams.pem"
  echo
fi