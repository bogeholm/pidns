#! /bin/bash

source logging.sh

info "Running tests..."

# Check cloudflared statusinfo "Assuming cloudflared is here: ${BINARY_LOCATION}"
cloudflared_isalive_check=$(cloudflared --version)

if [[ $? != 0 ]]; then
    error "Could not call cloudflared: 'cloudflared --version' failed"
    exit 1
fi

ok "'cloudflared --version' succeeded: ${cloudflared_isalive_check}"

# Check service status
cloudflared_service_check=$(systemctl is-active cloudflaredns)

if [[ $? != 0 ]]; then
    error "Service not running: 'systemctl is-active cloudflaredns' said '${cloudflared_service_check}'"
    exit 1
fi

ok "'systemctl is-active cloudflaredns' succeeded: ${cloudflared_service_check}"