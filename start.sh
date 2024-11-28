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
parar="start"
clear

loading() {
for ((i=0; i<=150; i++)); do
    progress=$(printf "%${i}s" "")
    progress=${progress// /▒}
    echo -ne "${LIGHT_BLUE}\r[$progress]${NC}"
    sleep 0.090
done
}

echo -e "${LIGHT_BLUE}Subindo projeto...${NC}"
docker compose up -d &
wait $!
echo -e "${LIGHT_RED}Parando container k3s...${NC}"
yes | docker compose rm k3s -s -f -v
# echo -e "${BROWN_ORANGE}Para colocar o contaner K3s como node do rancher, espere uns 3 minutos e execute ${NC}${PURPLE}novo-k3s-refazer-token.sh${NC}"
echo -e "${LIGHT_BLUE}Aguardando subir o rancher para obter o token de acesso inicial...${NC}"

loading &
sleep 31
echo

./obter-senha-inicial-rancher.sh


loading &
sleep 31
echo

./novo-k3s-refazer-token.sh