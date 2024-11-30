#! /bin/bash

# Silly script that either aquires all logins of a specified user, or the last login of that user

list_all=false
use_regex=false
user="root"

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -a|--all)
        list_all=true
        shift
        ;;
        -r|--regex)
        use_regex=true
        shift
        ;;
        *)
        user=${1}
        shift
        ;;
    esac
done

grep_flags=""
if [ use_regex ]; then
    grep_flags="-P"
fi

logins=$(last | grep "${grep_flags}" "${user}")
if [ ! list_all ]; then
    logins=$(echo "${logins}" | tail -1)
fi

echo "${logins}"
