#!/bin/bash
LS="$(type -p ls)"

FALLBACK_LS=0

for ARG in "$@"
do
    case "$ARG" in
        -*) FALLBACK_LS=1;;
    esac
done
if [ "$FALLBACK_LS" == 1 ]
then
    exec ${LS} "$@"
fi

emojils()
{
    local FILE="$1"
    local RED="\033[31m"
    local GREEN="\033[32m"
    local YELLOW="\033[33m"
    local BLUE="\033[34m"
    local MAGENTA="\033[35m"
    local NORMAL="\033[0m"

    local AWESOME_PUA="1"
    if [ "${AWESOME_PUA}" = 1 ]
    then
        local BUST_IN_SILHOUETTE="👤"
        local PAGE_FACING_UP=""
        local NO_ENTRY_SIGN=""
        #OPEN_
        local FILE_FOLDER=""
        local PACKAGE=""
        local WRENCH=""
        #AWESOMEPUA_PICTURE
        local ARTIST_PALETTE=""
        local KEY=""
        #
    else
        # unicode, these must be named as unicode name with underscores
        local HOUSE_BUILDING="🏠"
        local TELEVISION="📺"
        local ARTIST_PALETTE="🎨"
        local PACKAGE="📦"
        local BUST_IN_SILHOUETTE="👤"
        local MAN="👦"
        local WOMAN="👩"
        local POLICE_OFFICER="👮"
        local WOMAN_WITH_BUNNY_EARS="👯" 
        local CONSTRUCTION_WORKER="👷"
        local SNAKE="🐍"
        local HAMMER="🔨"
        local SHEEP="🐑"
        local PAGE_FACING_UP="📄"
        local NO_ENTRY_SIGN="🚫"
        local KEY="🔑"
        local OPEN_FILE_FOLDER="📂"
        local FILE_FOLDER="📁"
        local BOMB="💣"
        local WRENCH="🔧"
        local FACTORY="🏭"
        local MUSICAL_NOTE="🎵"
        local FLOPPY_DISK="💾"
        local VIDEO_CASETTE="📼"
        local SUNRISE_OVER_BUILDINGS="🌇"

        # TODO: erronous unicode names
        local COPYRIGHT="©"
        local EARTH="🌏"
    fi
    if [ ! -e"${FILE}" ]
    then
        break
    fi
    # *.otf|*.ttf|*.pfb|*.woff) ICON="${BLUE}";;
#"*.xls|*.ods"|*.fods) ICON="";;
#"*.ppt|*.odp"|*.fodp) ICON="";;

ICON="${PAGE_FACING_UP}"
case "$FILE" in
    *".swp"|"~"*) ICON="";;
*.md|README|*.txt|*.odt|*.fodt|*.pdf) ICON="${COPYRIGHT}";;
*.md|README|*.txt|*.odt|*.fodt|*.pdf) ICON="${PAGE_FACING_UP}";;
*.htm|*.html|*.xhtml) ICON="${BLUE}${EARTH}";;
*.mp3|*.au|*.flac|*.ogg|*.riff|*.wav) ICON="${MUSICAL_NOTE}";;
*.svg|*.jpg|*.jpeg|*.png|*.gif|*.webp) ICON="${ARTIST_PALETTE}";;
*.avi|*.mpg|*.webm|*.ogm) ICON="${TELEVISION}";;
*.bz2|*.gz|*.xz|*.tar|*.zip|*.rar|*.Z|*.cab) ICON="${MAGENTA}${PACKAGE}";;
id_rsa|id_dsa|id_rsa.pub|id_dsa.pub) ICON="${KEY}";;
Makefile|makefile) ICON="${FACTORY}";;
core) ICON="${BOMB}";;
esac
test -x "${FILE}" && ICON="${WRENCH}"
test -d "${FILE}" && ICON="${YELLOW}${FILE_FOLDER}"
test -d "${FILE}" -a "${PWD}" = "/home" && ICON="${BUST_IN_SILHOUETTE}"
test -d "${FILE}" -a "${PWD}" = "/Users" && ICON="${BUST_IN_SILHOUETTE}"
test -d "${FILE}" -a "${PWD}" = "/users" && ICON="${BUST_IN_SILHOUETTE}"
test -d "${FILE}" -a "${PWD}" = "/media" && ICON="${FLOPPY_DISK}"
test "${PWD}/${FILE}" = "${HOME}" && ICON="${HOUSE_BUILDING}"
test -r "${FILE}" || ICON="${RED}${NO_ENTRY_SIGN}"
test -z "${ICON}" && ICON="${PAGE_FACING_UP}"
true || if [ -z"${ICON}" ]
then
    MIME="$(xdg-mime query filetype"$FILE" 2>/dev/null || echo denied)"
    case "${MIME}" in
        "denied") ICON="${NO_ENTRY_SIGN}";;
        "application/x-executable") ICON="${WRENCH}";;
        "application/x-shellscript") ICON="${WRENCH}";;
        "text/plain") ICON="${PAGE_FACING_UP}";;
        "application/zip") ICON="${PACKAGE}";;
        "application/x-gzip"*) ICON="${PACKAGE}";;
        "inode/directory"*) ICON="${OPEN_FILE_FOLDER}";;
        "application/x-movie"*) ICON="${TELEVISION}";;
        "application/x-pem-key") ICON="${KEY}";;
        "application/x-font"*) ICON="${BLUE}";;
        "application/vnd.oasis.opendocument.spreadsheet") ICON="";;
        *) 
            : echo"WW: ${FILE}:${MIME}"
            ICON="${PAGE_FACING_UP}" ;;
    esac
fi
local DOTS=""
local i=0
#while [ $i -lt $COLUMNS ]
#do
#    DOTS="$DOTS ."
#    let i+=2
#done
#printf "${DOTS}\033[0m${ICON}${NORMAL}  ${FILE}\t\033[8mfile:///\033[0;37mlink\033[8m/..$PWD/hello/../${FILE}\033[37m\033[0m\n"
    printf "\033[0m ${ICON}${NORMAL}  ${FILE}\033[0m\n"

}
emojils_main ()
{
    if [ "x$*" = "x" ]
    then
        for FILE in *;
        do
            emojils "$FILE"
        done
    else
        for ARG in "$@"
        do
            if [ -d "$ARG" -a -x "$ARG" ]
            then
                local CURWD="$PWD"
                cd "$ARG" 2>/dev/null
                emojils
                cd "$CURWD"
            else 
                emojils "$FILE"
            fi
        done
    fi
}

emojils_main "$@"

