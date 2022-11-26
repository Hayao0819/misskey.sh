#!/usr/bin/env bash

CheckAuth(){
    if [[ -e "$MISSKEY_AUTH_FILE" ]]; then
        # shellcheck source=/dev/null
        source "$MISSKEY_AUTH_FILE"
    fi

    if [[ -z "${MISSKEY_DOMAIN-""}" ]] || [[ -z "${MISSKEY_TOKEN-""}" ]]; then
        Msg.Err "Misskey domain and token are not set."
        Msg.Err "Please run 'misskey.sh setup' to set them."
        exit 1
    fi

    Misskey.Setup "${MISSKEY_DOMAIN}" "${MISSKEY_TOKEN}"
}
