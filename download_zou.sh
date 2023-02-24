#!/bin/sh

# Colors for terminal
RST='\033[0m' # Text Reset

# Regular Colors
Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;37m'  # White

# Bold
BBlack='\033[1;30m'  # Black
BRed='\033[1;31m'    # Red
BGreen='\033[1;32m'  # Green
BYellow='\033[1;33m' # Yellow
BBlue='\033[1;34m'   # Blue
BPurple='\033[1;35m' # Purple
BCyan='\033[1;36m'   # Cyan
BWhite='\033[1;37m'  # White

# Bold High Intensity
BIBlack='\033[1;90m'  # Black
BIRed='\033[1;91m'    # Red
BIGreen='\033[1;92m'  # Green
BIYellow='\033[1;93m' # Yellow
BIBlue='\033[1;94m'   # Blue
BIPurple='\033[1;95m' # Purple
BICyan='\033[1;96m'   # Cyan
BIWhite='\033[1;97m'  # White

## Get latest version

lower_ZOU_VERSION=$(echo "${ZOU_VERSION}" | tr '[:upper:]' '[:lower:]')
if [ ${lower_ZOU_VERSION} == "latest" ]; then
    echo -e "${YELLOW}Checking what's the latest version of zou is.${RST}"
    export ZOU_VERSION=$(curl https://pypi.org/pypi/zou/json | jq -r '.info.version')

    if [ ${ZOU_VERSION} == "null" ]; then
        echo -e "${BIRed}Pypi API rate limit exceeded. Can't check for later versions. Please try again later${RST}"
        echo -e "${BIRed}Please set the wanted version on ${YELLOW}ZOU_VERSION${RST}"
    fi

    echo -e "Setting ZOU_VERSION to ${Green}$ZOU_VERSION${RST}"
fi

pip install --upgrade pip setuptools zou==${ZOU_VERSION}
export ZOU_VERSION=/usr/local/lib/python${PY_V}/site-packages/zou
