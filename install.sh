#! /bin/bash

source logging.sh

DEFAULT_BINARY_LOCATION="/usr/local/bin"

while getopts "b:" opt; do
    case $opt in
        # Remove trailing slash, if any
        b) BINARY_LOCATION="${OPTARG%/}"
        ;;
        \?) echo "Invalid option '$OPTARG'. Use: 'install.sh -b'"
        exit 1
        ;;
    esac
done

if [[ -z "${BINARY_LOCATION}" ]]; then
    BINARY_LOCATION=${DEFAULT_BINARY_LOCATION}
fi

info "Assuming cloudflared is here: ${BINARY_LOCATION}"
cloudflared_isalive_check=$("${BINARY_LOCATION}/cloudflared" --version)

if [[ $? != 0 ]]; then
    error "Could not locate binary: '${BINARY_LOCATION}/cloudflared --version' failed"
    exit 1
fi
ok "'${BINARY_LOCATION}/cloudflared --version' succeeded: ${cloudflared_isalive_check}"

info "Creating '/etc/systemd/system/cloudflaredns.service' ..."
sed -e "s#{{CLOUDFLARED_LOCATION}}#${BINARY_LOCATION}#" cloudflaredns.service.template > /etc/systemd/system/cloudflaredns.service

info "Enabling cloudflaredns.service"
info "Check status with 'systemctl status cloudflaredns'"
systemctl enable cloudflaredns.service
