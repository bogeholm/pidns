#! /usr/bin/env bash

source common.sh
source logging.sh

while getopts ":b:d:p:s:" opt; do
    case ${opt} in
        # Remove trailing slash, if any
        b) BINARY_LOCATION="${OPTARG%/}"
        ;;
        d) DNS_PRIMARY="${OPTARG}"
        ;;
        p) DNS_LOCAL_PORT="${OPTARG}"
        ;;
        s) DNS_SECONDARY="${OPTARG}"
        ;;
        \?) echo "Invalid option '${OPTARG}'. Use: 'install-service.sh [-b -d -p -s]'"
        exit 1
        ;;
    esac
done

if [[ -z "${BINARY_LOCATION}" ]]; then
    BINARY_LOCATION=${DEFAULT_CLOUDFLARED_DESTINATION}
fi

if [[ -z "${DNS_PRIMARY}" ]]; then
    DNS_PRIMARY=${DEFAULT_DNS_PRIMARY}
fi

if [[ -z "${DNS_LOCAL_PORT}" ]]; then
    DNS_LOCAL_PORT=${DEFAULT_DNS_LOCAL_PORT}
fi

if [[ -z "${DNS_SECONDARY}" ]]; then
    DNS_SECONDARY=${DEFAULT_DNS_SECONDARY}
fi

info "Primary DNS: ${DNS_PRIMARY}"
info "Secondary DNS: ${DNS_SECONDARY}"
info "Local DNS port: ${DNS_LOCAL_PORT}"

info "Assuming cloudflared is here: ${BINARY_LOCATION}"
cloudflared_isalive_check=$("${BINARY_LOCATION}/cloudflared" --version)

if [[ $? != 0 ]]; then
    error "Could not locate binary: '${BINARY_LOCATION}/cloudflared --version' failed"
    exit 1
fi

ok "'${BINARY_LOCATION}/cloudflared --version' succeeded: ${cloudflared_isalive_check}"

TEMPFILE="$(uuidgen).service"
info "Creating '/etc/systemd/system/cloudflaredns.service' ..."
sed -e "s#{{CLOUDFLARED_LOCATION}}#${BINARY_LOCATION}#" \
    -e "s#{{DNS_PRIMARY}}#${DNS_PRIMARY}#" \
    -e "s#{{DNS_LOCAL_PORT}}#${DNS_LOCAL_PORT}#" \
    -e "s#{{DNS_SECONDARY}}#${DNS_SECONDARY}#" \
    cloudflaredns.service.template > ${TEMPFILE}

# Overwrite destination
mv ${TEMPFILE} /etc/systemd/system/cloudflaredns.service

systemctl enable cloudflaredns.service
ok "Enabled cloudflaredns.service"
info "Reboot - and then check status with 'systemctl status cloudflaredns'"
