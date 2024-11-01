#!/usr/bin/env sh

# define functions

function print_error
{
cat << "EOF"
    ./volumecontrol.sh -[device] <action>
    ...valid device are...
        i -- [i]nput decive
        o -- [o]utput device
    ...valid actions are...
        i -- <i>ncrease volume [+5]
        d -- <d>ecrease volume [-5]
        m -- <m>ute [x]
EOF
}

function notify_vol
{
    vol=`pamixer $srce --get-volume | cat`
    dunstify "vol" -a "muted" "$nsink ${vol}%" -r 91190 -t 800
}

function notify_mute
{
    mute=`pamixer $srce --get-mute | cat`
    if [ "$mute" == "true" ] ; then
        dunstify "vol" -a "muted" "$nsink muted" -r 91190 -t 800
    else
        dunstify "vol" -a "muted" "$nsink unmuted" -r 91190 -t 800
    fi
}


# set device source

while getopts io SetSrc
do
    case $SetSrc in
    i) nsink=$(pamixer --list-sources | grep "_input." | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
        srce="--default-source"
        dvce="mic" ;;
    o) nsink=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
        srce=""
        dvce="speaker" ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    print_error
fi


# set device action

shift $((OPTIND -1))
step="${2:-5}"

case $1 in
    i) pamixer $srce -i ${step}
        notify_vol ;;
    d) pamixer $srce -d ${step}
        notify_vol ;;
    m) pamixer $srce -t
        notify_mute ;;
    *) print_error ;;
esac

