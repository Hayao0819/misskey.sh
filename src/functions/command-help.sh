#!/usr/bin/env bash

Command.Help(){
    if (( "$#" < 1 )); then
        ScriptUsage
        exit 1
    fi

    case "$1" in
        "setup" )
            shift 1
            Command.Help.Setup "${@}"
            ;;
        "note" )
            shift 1
            Command.Help.Note "${@}"
            ;;
        "timeline" )
            shift 1
            Command.Help.Timeline "${@}"
            ;;
        "whoami" )
            shift 1
            Command.Help.Whoami "${@}"
            ;;
        "help" )
            shift 1
            Command.Help.Help "${@}"
            ;;
        * )
            Msg.Err "Unknown command $1"
            exit 1
            ;;
        esac
}


Command.Help.Help(){
    echo "Usage: misskey.sh $Command [command]"
    echo
    echo "Show each command's help"
    echo
    echo "There is no options for this command"
}

Command.Help.Setup(){
    echo "Usage: misskey.sh $Command [Domain] [Token]"
    echo
    echo "Setup this Misskey client"
    echo
    echo "このスクリプトは${MISSKEY_AUTH_FILE}に認証情報を保存します。"
    echo "トークンは設定から取得してください。"
}

Command.Help.Note(){
    echo "Usage: misskey.sh $Command [options] [NoteText]"
    echo
    echo "Post a note to Misskey"
    echo
    echo "Options:"
    echo "  -v | --visibility [public|home|followers|specified|private] "
    echo "                Set visibility of the note"
}
