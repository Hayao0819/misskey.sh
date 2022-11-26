#!/usr/bin/env bash


Command="${1:-""}"

[[ "$Command" = "setup" ]] || CheckAuth

case "${Command}" in
    "setup" )
        shift 1
        Command.Setup "${@}"
        ;;
    "note" )
        shift 1
        Command.Note "${@}"
        ;;
    "timeline" )
        shift 1
        Command.Timeline "${@}"
        ;;
    "whoami" )
        shift 1
        Command.Whoami "${@}"
        ;;
    "help" )
        shift 1
        Command.Help "${@}"
        ;;
    * )
        ScriptUsage
        exit 1
    ;;
esac
