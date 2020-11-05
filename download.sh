#! /bin/bash

source logging.sh

# Example URL
# https://github.com/cloudflare/cloudflared/releases/download/2020.10.2/cloudflared-linux-armv6
DEFAULT_VERSION="2020.10.2"
DEFAULT_DESTINATION="/usr/local/bin"

while getopts ":v:d:" opt; do
    case $opt in
        v) VERSION="$OPTARG"
        ;;
        d) DESTINATION="$OPTARG"
        ;;
        \?) echo "Invalid option '$OPTARG'. Use: 'download.sh -v -d'"
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

info "Version: ${VERSION}"
info "Destination: ${DESTINATION}"
URL="https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-linux-armv6"

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
