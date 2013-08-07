#!/bin/bash
LS="$(type -p ls)"

AUTOGLOB=true
for ARG in "$@"
do
    AUTOGLOB=false

	case "${ARG}" in
        -*) exec ${LS} "$@"; exit 0;;
        esac
done

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
NORMAL="\033[0m"

AWESOME_PUA="1"
if [ "${AWESOME_PUA}" = 1 ]
then
BUST_IN_SILHOUETTE="👤"
PAGE_FACING_UP=""
NO_ENTRY_SIGN=""
#OPEN_
FILE_FOLDER=""
PACKAGE=""
WRENCH=""
#AWESOMEPUA_PICTURE
ARTIST_PALETTE=""
KEY=""
#
else
# unicode, these must be named as unicode name with underscores
HOUSE_BUILDING="🏠"
TELEVISION="📺"
ARTIST_PALETTE="🎨"
PACKAGE="📦"
BUST_IN_SILHOUETTE="👤"
MAN="👦"
WOMAN="👩"
POLICE_OFFICER="👮"
WOMAN_WITH_BUNNY_EARS="👯" 
CONSTRUCTION_WORKER="👷"
SNAKE="🐍"
HAMMER="🔨"
SHEEP="🐑"
PAGE_FACING_UP="📄"
NO_ENTRY_SIGN="🚫"
KEY="🔑"
OPEN_FILE_FOLDER="📂"
FILE_FOLDER="📁"
BOMB="💣"
WRENCH="🔧"
FACTORY="🏭"
MUSICAL_NOTE="🎵"
FLOPPY_DISK="💾"
VIDEO_CASETTE="📼"
SUNRISE_OVER_BUILDINGS="🌇"

# TODO: erronous unicode names
COPYRIGHT="©"
EARTH="🌏"
fi

for FILE in *;
do
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
*) 
: echo"WW: ${FILE}:${MIME}"
ICON="${PAGE_FACING_UP}" ;;
esac
#"application/x-font"*) ICON="${BLUE}";;
#"application/vnd.oasis.opendocument.spreadsheet") ICON="";;
fi
DOTS=""
i=0
#while [ $i -lt $COLUMNS ]
#do
#    DOTS="$DOTS ."
#    let i+=2
#done
#printf "${DOTS}\033[0m${ICON}${NORMAL}  ${FILE}\t\033[8mfile:///\033[0;37mlink\033[8m/..$PWD/hello/../${FILE}\033[37m\033[0m\n"
printf "\033[0m ${ICON}${NORMAL}  ${FILE}\033[0m\n"
done


