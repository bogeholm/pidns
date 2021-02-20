#! /usr/bin/env bash

source common.sh
source github-latest.sh
source logging.sh

while getopts ":v:d:a:" opt; do
    case $opt in
        a) ARCHITECTURE="$OPTARG"
        ;;
        d) DESTINATION="$OPTARG"
        ;;
        v) VERSION="$OPTARG"
        ;;
        \?) echo "Invalid option '$OPTARG'. Use: 'install-binary.sh [-a -d -v]'"
        exit 1
        ;;
    esac
done

TEMPDIR="tmp-$(uuidgen)"

if [[ -z "${VERSION}" ]]; then
    VERSION=${DEFAULT_CLOUDFLARED_VERSION}
fi

if [[ -z "${DESTINATION}" ]]; then
    DESTINATION=${DEFAULT_CLOUDFLARED_DESTINATION}
fi

if [[ -z "${ARCHITECTURE}" ]]; then
    ARCHITECTURE=${DEFAULT_CLOUDFLARED_ARCHITECTURE}
fi

# Get latest version from GitHub if specified
if [[ $(echo ${VERSION} | tr '[:upper:]' '[:lower:]') = "latest" ]]; then
    info "Version: ${VERSION}"
    info "Checking GitHub for latest release ..."
    VERSION="$(github_latest)"
fi

if [[ -z "${VERSION}" ]]; then
    error "Could not get latest release from GitHub"
    exit 1
fi

info "Version: ${VERSION}"
info "Destination: ${DESTINATION}"
URL="https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-${ARCHITECTURE}"

mkdir -p $TEMPDIR
pushd $TEMPDIR
    info "Downloading ${URL}..."
    curl --proto '=https' --tlsv1.2 -fL "${URL}" --output cloudflared
    chmod +x cloudflared
    cloudflared_downloaded_version=$(./cloudflared --version)

    if [[ $? != 0 ]]; then
        error "Could not run './cloudflared --version'"
        rm -rf ${TEMPDIR}
        exit 1
    fi

    ok "$cloudflared_downloaded_version"
popd

mv "${TEMPDIR}/cloudflared" "${DESTINATION}/cloudflared"
rm -rf ${TEMPDIR}
ok "Installed cloudflared to ${DESTINATION}"
