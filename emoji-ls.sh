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

AWESOME_PUA="0"
if [ "${AWESOME_PUA}" = 1 ]
then
BUST_IN_SILHOUETTE=""
PAGE_FACING_UP=""
NO_ENTRY_SIGN=""
OPEN_FILE_FOLDER=""
PACKAGE=""
WRENCH=""
AWESOMEPUA_PICTURE=""
else
# unicode, these must be named as unicode name with underscores
HOUSE_BUILDING="🏠 "
TELEVISION="📺 "
ARTIST_PALETTE="🎨 "
PACKAGE="📦 "
BUST_IN_SILHOUETTE="👤 "
MAN="👦 "
WOMAN="👩 "
POLICE_OFFICER="👮 "
WOMAN_WITH_BUNNY_EARS="👯 " 
CONSTRUCTION_WORKER="👷 "
SNAKE="🐍 "
HAMMER="🔨 "
SHEEP="🐑 "
PAGE_FACING_UP="📄 "
NO_ENTRY_SIGN="🚫 "
KEY="🔑 "
OPEN_FILE_FOLDER="📂 "
FILE_FOLDER="📁 "
BOMB="💣 "
WRENCH="🔧 "
FACTORY="🏭 "
MUSICAL_NOTE="🎵 "
FLOPPY_DISK="💾 "
VIDEO_CASETTE="📼 "
SUNRISE_OVER_BUILDINGS="🌇 "
fi

for FILE in *;
do
if [ ! -e "${FILE}" ]
then
	break
fi
# *.otf|*.ttf|*.pfb|*.woff) ICON="${BLUE}";;
#"*.xls|*.ods"|*.fods) ICON="";;
#"*.ppt|*.odp"|*.fodp) ICON="";;

ICON=""
case "$FILE" in
*".swp"|"~"*) ICON="";;
*.md|README|*.txt|*.odt|*.fodt|*.pdf) ICON="${PAGE_FACING_UP}";;
*.htm|*.html|*.xhtml) ICON="${BLUE}";;
*.svg|*.jpg|*.jpeg|*.png|*.gif|*.webp) ICON="${ARTIST_PALETTE}";;
*.avi|*.mpg|*.webm|*.ogm) ICON="${TELEVISION}";;
*.bz2|*.gz|*.xz|*.tar|*.zip|*.rar|*.Z|*.cab) ICON="${MAGENTA}${PACKAGE}";;
esac
test -x "${FILE}" && ICON="${WRENCH}"
test -d "${FILE}" && ICON="${YELLOW}${FILE_FOLDER}"
test -d "${FILE}" -a "${PWD}" = "/home" && ICON="${BUST_IN_SILHOUETTE}"
test -d "${FILE}" -a "${PWD}" = "/Users" && ICON="${BUST_IN_SILHOUETTE}"
test -d "${FILE}" -a "${PWD}" = "/users" && ICON="${BUST_IN_SILHOUETTE}"
test -d "${FILE}" -a "${PWD}" = "/media" && ICON=""
test -r "${FILE}" || ICON="${RED}${NO_ENTRY_SIGN}"

if [ -z "${ICON}" ]
then
MIME="$(xdg-mime query filetype "$FILE" 2>/dev/null || echo denied)"
case "${MIME}" in
"denied") ICON="${NO_ENTRY_SIGN}";;
"application/x-executable") ICON="${WRENCH}";;
"application/x-shellscript") ICON="${WRENCH}";;
"text/plain") ICON="${PAGE_FACING_UP}";;
"application/zip") ICON="${PACKAGE}";;
"application/x-gzip"*) ICON="${PACKAGE}";;
"inode/directory"*) ICON="${OPEN_FILE_FOLDER}";;
"application/x-movie"*) ICON="";;
"application/x-pem-key") ICON="";;
*) 
: echo "WW: ${FILE}:${MIME}"
ICON="${PAGE_FACING_UP}" ;;
esac
#"application/x-font"*) ICON="${BLUE}";;
#"application/vnd.oasis.opendocument.spreadsheet") ICON="";;
fi
printf " ${ICON}${NORMAL} ${FILE}\n"
done


