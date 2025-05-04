#!/bin/bash

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Move to container working directory
cd /home/container || exit 1
sleep 1

# Set timezone
TZ=${TZ:-UTC}
export TZ

# Get internal IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Info banner
echo -e "${BLUE}-------------------------------------------------${NC}"
echo -e "${RED}PMMP Server (Debian-based)${NC}"
echo -e "${BLUE}-------------------------------------------------${NC}"
echo -e "${YELLOW}Timezone: ${RED}${TZ}${NC}"
echo -e "${YELLOW}PHP Version: ${RED}$(php -v | head -n 1)${NC}"
echo -e "${BLUE}-------------------------------------------------${NC}"

# Export path
export PATH=$PATH:/root/.local/bin

# Replace startup vars
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Execute startup
eval "${MODIFIED_STARTUP}"
