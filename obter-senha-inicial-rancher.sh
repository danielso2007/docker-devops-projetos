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

echo -e "${LIGHT_BLUE}Instalando o xclip...${NC}"
sudo apt-get install xclip &
wait $!

echo -e "${LIGHT_BLUE}Obter o token de acesso do rancher...${NC}"
senha_rancher=$(docker compose logs rancher 2>&1 | grep "Bootstrap Password:"  | sed 's/.*Password: //')

docker compose logs rancher 2>&1 | grep "Bootstrap Password:"  | sed 's/.*Password: //' | xclip -selection clipboard

link="https://rancher.local/dashboard/?setup=${senha_rancher}"

echo -e "${BROWN_ORANGE}Senha inicial do rancher copiada na memória!!${NC}"
echo -e "${BROWN_ORANGE}Acesse:${NC} ${LIGHT_CYAN}${link}${NC}"
xdg-open "$link"
echo