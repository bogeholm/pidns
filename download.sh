#! /bin/bash

source logging.sh

# Example URL
# https://github.com/cloudflare/cloudflared/releases/download/2020.11.11/cloudflared-linux-armv6
DEFAULT_VERSION="2020.11.11"
DEFAULT_DESTINATION="/usr/local/bin"
DEFAULT_ARCHITECTURE="linux-armv6"

while getopts ":v:d:a:" opt; do
    case $opt in
        a) ARCHITECTURE="$OPTARG"
        ;;
        d) DESTINATION="$OPTARG"
        ;;
        v) VERSION="$OPTARG"
        ;;
        \?) echo "Invalid option '$OPTARG'. Use: 'download.sh -a -d -v'"
        exit 1
        ;;
    esac
done

if [[ -z "${VERSION}" ]]; then
    VERSION=${DEFAULT_VERSION}
fi

if [[ -z "${DESTINATION}" ]]; then
    DESTINATION=${DEFAULT_DESTINATION}
fi

if [[ -z "${ARCHITECTURE}" ]]; then
    ARCHITECTURE=${DEFAULT_ARCHITECTURE}
fi

info "Version: ${VERSION}"
info "Destination: ${DESTINATION}"
URL="https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-${ARCHITECTURE}"

pushd tmp/
    info "Downloading ${URL}..."
    curl --proto '=https' --tlsv1.2 -fL "${URL}" --output cloudflared
    chmod +x cloudflared
    cloudflared_downloaded_version=$(./cloudflared --version)

    if [[ $? != 0 ]]; then
        error "Could not run './cloudflared --version'"
        exit 1
    fi

    ok "$cloudflared_downloaded_version"
popd

info "Moving cloudflared to ${DESTINATION}"
mv tmp/cloudflared "${DESTINATION}/cloudflared"
