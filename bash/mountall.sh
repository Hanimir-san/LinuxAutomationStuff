#! /bin/bash
# Silly script that mounts all partitions on a system
# You know, for when you don't want to use fstab

if [ $(id --user) -ne "0" ]; then
    printf "My guy, you're trying to mount things without root privileges. This is silly. We'll stop here.\n"
    exit 1
fi

disk_fs_types=("ext4" "btrfs" "ntfs")
flash_fs_types=("exfat")
all_fs_types=( "${disk_fs_types[@]}" "${flash_fs_types[@]}" )

parts=$(lsblk --noheadings --raw --output "NAME,FSTYPE,LABEL,PATH,MOUNTPOINT")

while IFS= read -r part; do
    part_name=$(printf "%s" "${part}" | cut --delimiter " " --fields 1)
    part_fs=$(printf "%s" "${part}" | cut --delimiter " " --fields 2)
    part_label=$(printf "%s" "${part}" | cut --delimiter " " --fields 3)
    part_path=$(printf "%s" "${part}" | cut --delimiter " " --fields 4)
    part_mount=$(printf "%s" "${part}" | cut --delimiter " " --fields 5)   
    
    # If the partition is already mounted, skip it
    if [ "${part_mount}" ]; then
        continue
    fi
    # If partition file system cannot be read, skip it
    if [ ! "${part_fs}" ]; then
        continue
    fi
    # If partition file system is not in the list of allowed file systems, skip it
    if [ $(printf '%s\0' "${all_fs_types[@]}" | grep --fixed-strings --line-regexp --count -- "${part_fs}") -eq "0" ];then
        continue
    fi
        
    # Chose mount location based on fs type
    mnt_root="/mnt"
    if [ $(printf '%s\0' "${flash_fs_types[@]}" | grep --fixed-strings --line-regexp --count -- "${part_fs}") -gt "0" ]; then
        mnt_root="/media"
    fi
    # If a partition label exists, use it for the mount name. Otherwise use the partition name
    mnt_name=$( [ -n "${part_label}" ] && printf "${part_label}" || printf "${part_name}" )
    mnt_path="${mnt_root}/${mnt_name}"

    # Create the mount directory
    if [ ! -d "${mnt_path}" ]; then
        printf "Creating mount directory \"${mnt_path}\"...\n"
        mkdir --parents "${mnt_path}"
    fi

    # Mount that thang
    printf "\e[0;33mMounting partition \"${part_name}\" under \"${mnt_path}\"...\n\e[0;0m"
    mount --type "${part_fs}" "${part_path}" "${mnt_path}" 

done <<< "${parts}"