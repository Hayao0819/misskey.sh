#!/usr/bin/env bash
set -eEuo pipefail

# ソースディレクトリの定義
CurrentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LibDir="${CurrentDir}/lib" SrcDir="${CurrentDir}/src"


# 作業ディレクトリの定義
WorkDir="${CurrentDir}/build"
SourceScriptsDir="${WorkDir}/source-scripts"
TmpOutFile="${WorkDir}/misskey.sh"



# Create work dir
rm -rf "${WorkDir}"
mkdir -p "$SourceScriptsDir"

# ディレクトリ移動
cd "$WorkDir" || exit 1

# FasBashLibをビルド
{
    "$LibDir/FasBashLib/bin/Build-Single.sh" -multimode -ver "FSBLIB-FOR-MISSKEY" -out "$SourceScriptsDir/FasBashLib.sh" BetterShell Misskey URL Parsrs ParseArg Message
} 2> "${WorkDir}/FasBashLib-build.log"

# スクリプトをコピー
cp "$SrcDir/functions/"*".sh" "$SourceScriptsDir"

# <ビルドを開始>
echo -n "" > "$TmpOutFile"

# headerを出力
cat "$SrcDir/header.sh" >> "$TmpOutFile"

# 関数を結合して出力
(
    while read -r Func; do
        unset -f "$Func"
    done < <(typeset -F | cut -d ' ' -f3)

    for File in "$SourceScriptsDir/"*".sh"; do
        # shellcheck source=/dev/null
        source "$File"
    done

    typeset -f >> "$TmpOutFile"
)

# footerを出力
cat "$SrcDir/footer.sh" >> "$TmpOutFile"



