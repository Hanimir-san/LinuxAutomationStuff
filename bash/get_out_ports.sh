#! /bin/bash
# Silly script that lists all currently used open ports and saves them
# to a file

file_trg_path="./port_list"

while [ ${#} -gt 0 ]; do
    case "${1}" in 
        -d|--destination)
            file_trg_path=${2}
            shift
            shift
            ;;
        -*)
            printf "Unknown option ${1}\n"
            exit 1
    esac
done

file_trg_dir=$(printf "${file_trg_path}" | rev | cut -d / -f 2- | rev)
echo $file_trg_dir

if [ ! -d ${file_trg_dir} ]; then
    mkdir -p ${file_trg_dir} 2>/dev/null
fi

netstat -tul | tail -n +2 | awk '{print $4}' | cut -d : -f 2  | sort > ${file_trg_path}
