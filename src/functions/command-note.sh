#!/usr/bin/env bash

Command.Note(){
    if (( "$#" < 1 )); then
        Command.Help.Note
        exit 1
    fi

    local NoteText="${1}" ReturnJSON APIArgs=()
    # shellcheck disable=SC2034
    local OPTRET

    # 引数解析
    ParseArg SHORT="v" LONG="visibility" -- "${@}"
    while  true; do
        echo "$1"
        case "$1" in
            "-v" | "--visibility" )
                if [[ "$2" = "public" || "$2" = "home" || "$2" = "followers" || "$2" = "specified" || "$2" = "private" ]]; then
                    APIArgs+=("visibility=$2")
                else
                    Msg.Err "Invalid visibility $2"
                    exit 1
                fi
                
                shift 2
                ;;
            --)
                shift
                break
                ;;
        esac
    done
    unset OPTRET

    # 投稿を実行
    ReturnJSON="$(Misskey.Notes.Create "${NoteText}" "${APIArgs[@]}")"

    # 結果
    local NoteId userName userId visibility
    NoteId=$(jq -r ".createdNote.id" <<< "$ReturnJSON")
    userName=$(jq -r ".createdNote.user.username" <<< "$ReturnJSON")
    userId=$(jq -r ".createdNote.user.id" <<< "$ReturnJSON")
    visibility=$(jq -r ".createdNote.visibility" <<< "$ReturnJSON")

    Msg.Info "${visibility}に${userName}($userId)として投稿(${NoteId})を作成しました。"

}
