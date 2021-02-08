#! /usr/bin/env bash

source common.sh
source logging.sh

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
    VERSION=${DEFAULT_CLOUDFLARED_VERSION}
fi

if [[ -z "${DESTINATION}" ]]; then
    DESTINATION=${DEFAULT_CLOUDFLARED_DESTINATION}
fi

if [[ -z "${ARCHITECTURE}" ]]; then
    ARCHITECTURE=${DEFAULT_CLOUDFLARED_ARCHITECTURE}
fi

info "Version: ${VERSION}"
info "Destination: ${DESTINATION}"
URL="https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-${ARCHITECTURE}"

mkdir tmp
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

mv tmp/cloudflared "${DESTINATION}/cloudflared"
rm -r tmp
ok "Installed cloudflared to ${DESTINATION}"
