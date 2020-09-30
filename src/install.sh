#!/bin/bash
source "${GITHUB_WORKSPACE}/.github/scripts/shutils.sh"
###############################################################################
# Install buildapp specific dependencies.
###############################################################################

installAptPackages nodejs
installAptPackages npm

npm install netlify-cli -g

R -e "remotes::install_github('hafen/trelliscopejs@new-features', upgrade = FALSE)"
R -e "remotes::install_github('WorldHealthOrganization/geoutils', upgrade = FALSE)"
R -e "remotes::install_github('WorldHealthOrganization/geocard', upgrade = FALSE)"
R -e "remotes::install_github('WorldHealthOrganization/casecountapp', upgrade = FALSE)"

exit 0
