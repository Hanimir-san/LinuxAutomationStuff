#! /bin/bash
# Silly script that returns the number of running processes by user 

proc_users=$(ps -eo "user=" | sort | uniq)

printf "Running processes by user\n\n"
for proc_user in ${proc_users}; do
    proc_num=$(ps -u ${proc_user} -U ${proc_user} | tail -n +2 | wc -l)
    printf "${proc_user}: ${proc_num}\n"
done
