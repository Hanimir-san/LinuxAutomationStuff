#! /bin/bash

# Silly bash script that uses the free command and gets only available memory from it

# If someone has the bright idea of passing the wide parameter to this script, the numbers
# of fields in the output changes
mem_available_field=7
if [ "${@}" ]; then
    if [ $(printf -- "${@}" | grep -c -P "(?:-w)|(?:--wide)") -gt "0" ]; then
        mem_available_field=8
    fi
fi

mem_available=$(free ${@} | tr --squeeze " " | cut --delimiter " " --field ${mem_available_field} | sed "2q;d")

printf "${mem_available}\n"