github_latest () {
    ORG_REPO=${1:-"cloudflare/cloudflared"}
    # https://docs.github.com/en/rest/reference/repos#releases
    URL="https://api.github.com/repos/${ORG_REPO}/releases/latest"
    HEADER="Accept: application/vnd.github.v3+json"

    # TODO: Capture this properly
    which_jq="$(which jq)"

    if [[ $? != 0 ]]; then
        echo "jq not found" >&2
        return 1
    fi

    latest=$(curl -sSfL --proto '=https' --tlsv1.2 -H "${HEADER}" "${URL}" | jq .tag_name)
    # Remove leading and trailing quotes - https://stackoverflow.com/questions/9733338
    latest="${latest%\"}"
    latest="${latest#\"}"
    echo ${latest}
}