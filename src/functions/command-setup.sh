#!/usr/bin/env bash

Command.Setup(){
    if (( "$#" < 2 )); then
        Command.Help.Setup
        exit 1
    fi

    local Domain="${1}" Token="${2}"

    echo -e "MISSKEY_DOMAIN=${Domain}\nMISSKEY_TOKEN=${Token}" > "$MISSKEY_AUTH_FILE"
    Msg.Info "認証情報を${MISSKEY_AUTH_FILE}に保存しました。"
    
}
