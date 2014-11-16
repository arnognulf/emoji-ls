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
    local ESC="\033"
    local FILE="$1"
    local BRIGHTRED="${ESC}[91m"
    local RED="${ESC}[31m"
    local GREEN="${ESC}[32m"
    local BRIGHTGREEN="${ESC}[92m"
    local YELLOW="${ESC}[33m"
    local CYAN="${ESC}[36m"
    local BRIGHTCYAN="${ESC}[96m"
    local BRIGHTYELLOW="${ESC}[91m"
    local BLUE="${ESC}[34m"
    local DOUBLE="${ESC}#6"
    local SINGLE="${ESC}#5"
    local BRIGHTBLUE="${ESC}[94m"
    local BGBRIGHTBLUE="${ESC}[104m"
    local BGBRIGHTWHITE="${ESC}[107m"
    local BGWHITE="${ESC}[47m"
    local BGBLUE="${ESC}[44m"
    local REVERSE="${ESC}[7m"
    local MAGENTA="${ESC}[35m"
    local NORMAL="${ESC}[0m"
    local WHITE="${ESC}[37m"
    local INVISIBLE="${ESC}[37;97m${ESC}[8m"
    #local INVISIBLE="${ESC}[7m" #reverse
    local ICON="x"
    local ICONCOLOR="${NORMAL}"
    local NONBREAKSPACE="_"
    local FAINT="${ESC}[37m"
    local BRIGHTWHITE="${ESC}[97m"

    local AWESOME_PUA="1"
    case "${TEMRNAME}" in
    gnome-terminal|konsole)
        local DIR_HOME=""
        local DIR_OTHERUSER=""
        local DEFAULT_FILE=""
        local FILE_TEXT=""
        local FILE_NOREAD="${RED}"
        local FILE_FOLDER="${YELLOW}"
        local FILE_ARCHIVE="${YELLOW}"
        local FILE_EXECUTABLE="${REVERSE}${BLUE}"
        local FILE_SO="${BLUE}"
        local FILE_EXE="${BRIGHTBLUE}"
        local FILE_AR="${YELLOW}"
        local FILE_KEY=""
        local FILE_PDF="${RED}"
        local FILE_ZIP="${FILE_ARCHIVE}"
        local FILE_CODE=""
        local FILE_RSS="${BRIGHTRED}"
        local FILE_IMAGE=""
        local FILE_EXCEL="${GREEN}"
        local FILE_WORD="${BLUE}"
        local FILE_VIDEO=""
        local FILE_AUDIO=""
        local FILE_DOC="${FILE_WORD}"
        local FILE_SPREADSHEET="${GREEN}"
        local FILE_TMP=""
        local FILE_CORE=""
        local FILE_HTML="${BLUE}"
        local FILE_FONT="${BLUE}"
        local FILE_MANUAL="${RED}"
        local FILE_O=""
        local FILE_HTML="${BRIGHTYELLOW}"
        local FILE_DB=""
        local FILE_CSS="${BRIGHTBLUE}"
        local FILE_APK="${BRIGHTGREEN}"
        local FILE_LINK="${REVERSE}${GREEN}"
        local FILE_PIPE="${GREEN}"
        local FILE_BLOCK=""
        local FILE_CHAR=""
        local FILE_CHAR=""
        local FILE_PIPE=""
        local FILE_BUILDSCRIPT=""
        local FILE_LICENSE=""

        ;;
        terminalapp)
        # unicode, these must be named as unicode name with underscores
        local DIR_HOME="🏠"
        local FILE_VIDEO="📺"
        local FILE_IMAGE="🎨"
        local FILE_ARCHIVE="📦"
        local DIR_OTHERUSER="👤"
        local DEFAULT_FILE="📄"
        local FILE_NOREAD="${RED}🚫"
        local FILE_KEY="🔑"
        local FILE_FOLDER="📁"
        local FILE_CORE="💣"
        local FILE_EXE=""
        local FILE_BUILDSCRIPT="🏭"
        local FILE_AUDIO="🎵"
        local FLOPPY_DISK="💾"
        ;;
        *) 
        local FILE_FOLDER="${YELLOW}[DIR]"
        case "${FILE}" in
            *.*) EXT="${FILE##*.}";;
            *) EXT="TXT";;
        esac
        UPPER_EXT=${EXT^^}
        case "${#UPPER_EXT}" in
            1) UPPER_EXT="  ${UPPER_EXT}";;
            2) UPPER_EXT=" ${UPPER_EXT}";;
            3) UPPER_EXT=" ${UPPER_EXT}";;
        esac

        UPPER_EXT="${UPPER_EXT}     "

        local FILE_EXECUTABLE="${BRIGHTGREEN} *** ${NORMAL}"
        local DEFAULT_FILE="${REVERSE}${UPPER_EXT:0:5}${NORMAL}"
        local FILE_PDF="${RED}${BGWHITE}${DEFAULT_FILE}"
        local FILE_AUDIO="${GREEN}${BGWHITE}${DEFAULT_FILE}"
        local FILE_IMAGE="${MAGENTA}${BGWHITE}${DEFAULT_FILE}"
        local FILE_ARCHIVE="${YELLOW}${BGWHITE}${DEFAULT_FILE}"
        local FILE_VIDEO="${CYAN}${BGBLACK}${DEFAULT_FILE}"
        local FILE_CODE="${BGBRIGHTWHITE}${GREEN}${DEFAULT_FILE}"
        local FILE_NOREAD="${RED}x x x"
        local FILE_LINK="${MAGENTA}<--->"
        local FILE_FONT="${WHITE}${BGBLUE}${DEFAULT_FILE}"
        local FILE_BUILDSCRIPT="${BGBLACK}${YELLOW}${DEFAULT_FILE}"

esac
if [ ! -e "${FILE}" ]
    then
        return
    fi

    local ICON="${DEFAULT_FILE}"
    case "${FILE,,}" in
        *.swp|"~"*) ICON="${FILE_TMP-${DEFAULT_FILE}}";;
        *.pdf|*.ps) ICON="${FILE_PDF-${DEFAULT_FILE}}";;
        *.ttf|*.otf|*.fon|*.woff) ICON="${FILE_FONT-${DEFAULT_FILE}}";;
        *.apk) ICON="${FILE_APK-${DEFAULT_FILE}}";;
        *.css) ICON="${FILE_CSS-${DEFAULT_FILE}}";;
        *.pl|*.xml|*.c|*.cpp|*.rb|*.py|*.m|*.h|*.hpp|*.sh|*.sfd|*.js|*.cs|*.java) ICON="${FILE_CODE-${DEFAULT_FILE}}";;
        *.rss) ICON="${FILE_RSS-${DEFAULT_FILE}}";;
        *.xls|*.ods|*.fods) ICON="${FILE_SPREADSHEET-${DEFAULT_FILE}}";;
        *.odt|*.docx|*.doc) ICON="${FILE_DOC-${DEFAULT_FILE}}";;
        *.htm|*.html|*.xhtml) ICON="${FILE_HTML-${DEFAULT_FILE}}";;
        *.mp3|*.mp4|*.au|*.flac|*.ogg|*.riff|*.wav|*.m4a|*.mid|*.mus) ICON="${FILE_AUDIO-${DEFAULT_FILE}}";;
        *.svg|*.jpg|*.jpeg|*.png|*.gif|*.webp|*.pp|*.ppm|*.xcf|*.dng|*.cr2|*.arw|*.raf|*.nef) ICON="${FILE_IMAGE-${DEFAULT_FILE}}";;
        *.avi|*.mpg|*.webm|*.ogm) ICON="${FILE_VIDEO-${DEFAULT_FILE}}";;
        *.bz2|*.gz|*.xz|*.tar|*.zip|*.rar|*.z|*.cab|*.deb|*.rpm) ICON="${FILE_ARCHIVE-${DEFAULT_FILE}}";;
        id_rsa|id_dsa|id_rsa.pub|id_dsa.pub) ICON="${FILE_KEY-${DEFAULT_FILE}}";;
        makefile|cmakelist.txt|cmakelists.txt|*.cmake|*.pri|*.pro|*.vcxproj|*.vcproj|*.sln) ICON="${FILE_BUILDSCRIPT-${DEFAULT_FILE}}";;
        core) ICON="${FILE_CORE-${DEFAULT_FILE}}";;
        *.o) ICON="${FILE_O-${DEFAULT_FILE}}";;
        *.1|*.man|*.info|*.chm) ICON="${FILE_MANUAL-${DEFAULT_FILE}}";;
        *.db|*.sqlite|*.sqlite3|*,v) ICON="${FILE_DB-${DEFAULT_FILE}}";;
        license*|copying*) ICON="${FILE_LICENSE-${DEFAULT_FILE}}";;
        readme*|*.md|*.txt|*rc|*.cfg|*.conf) ICON="${FILE_TEXT-${DEFAULT_FILE}}";;
        *.exe|*.msi) ICON="${FILE_EXE-${DEFAULT_FILE}}";;
    esac
    test -x "${FILE}" && ICON="${FILE_EXECUTABLE-${DEFAULT_FILE}}"


    case "${FILE}" in
        *.so*|*.dll) ICON="${FILE_SO-${DEFAULT_FILE}}"
    esac

    test -d "${FILE}" && ICON="${FILE_FOLDER-${DEFAULT_FILE}}"

    test -d "${FILE}" -a "${PWD}" = "/home" && ICON="${DIR_OTHERUSER-${DEFAULT_FILE}}"
    test -d "${FILE}" -a "${PWD}" = "/Users" && ICON="${DIR_OTHERUSER-${DEFAULT_FILE}}"
    test -d "${FILE}" -a "${PWD}" = "/users" && ICON="${DIR_OTHERUSER-${DEFAULT_FILE}}"
    test -d "${FILE}" -a "${PWD}" = "/media" && ICON="${FLOPPY_DISK-${DEFAULT_FILE}}"
    test "${PWD}/${FILE}" = "${HOME}" && ICON="${DIR_HOME-${DEFAULT_FILE}}"
    test -h "${FILE}" && ICON="${FILE_LINK-${DEFAULT_FILE}}"
    test -r "${FILE}" || { ICON="${FILE_NOREAD-${DEFAULT_FILE}}"; }
    test -b "${FILE}" && ICON="${FILE_BLOCK-${DEFAULT_FILE}}"
    test -c "${FILE}" && ICON="${FILE_CHAR-${DEFAULT_FILE}}"
    test -p "${FILE}" && ICON="${FILE_PIPE-${DEFAULT_FILE}}"

    local LINKFILE=${FILE/ /${FAINT}%%20${NORMAL}}
    local LINKFILENOCOLOR=${FILE/ /%%20}
    LOC=$(($COLUMNS - ${#EMOJITEMP} - ${#LINKFILENOCOLOR} - 13))
    printf "${ESC}[${LOC}G ${FAINT}(file://${EMOJITEMP}/_/${NORMAL}${LINKFILE}${FAINT})${NORMAL} ${ESC}[0G ${ICON} ${NORMAL} ${FILE}  \n"
}

emojils_main ()
{
    if [ -z ${NO_RC} ]
    then
        test -f "$HOME/.emojils.sh" && . "$HOME/.emojils.sh"
        rm -f "$HOME/.emojils.sh"
    fi
    if [ -z "${TMPDIR}" ]
    then
        TMPDIR="/tmp"
    fi
    local EMOJITEMP=$(TMPDIR=$TMPDIR mktemp -d ${TMPDIR}/_XXX || mktemp -d -t 'mytmpdir')
    ln -s "$(pwd)" "${EMOJITEMP}/_"

    if [ "x$*" = "x" ]
    then
        for FILE in *;
        do
            EMOJITEMP="$EMOJITEMP" emojils "$FILE"
        done
    else
        for ARG in "$@"
        do
            if [ -d "$ARG" -a -x "$ARG" ]
            then
                local CURWD="$PWD"
                cd "$ARG" 2>/dev/null
                NO_RC=1 emojils_main
                cd "$CURWD"
            else 
                EMOJITEMP="$EMOJITEMP" emojils "$ARG"
            fi
        done
    fi
    echo "rm -rf \"${EMOJITEMP}\"" >> $HOME/.emojils.sh
}
test -n "${WINDOWID}" && case "$(xprop -id ${WINDOWID})" in
    *Gnome-terminal*) TERMNAME=gnome-terminal;;
    *XTerm*) TERMNAME=xterm;;
    *Konsole*) TERMNAME=konsole;;
esac
test "$TERM_PROGRAM" = "Apple_Terminal" && TERMNAME=terminalapp
shopt -s checkwinsize
printf "\n"
emojils_main "$@"

