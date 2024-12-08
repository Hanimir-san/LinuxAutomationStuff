#! /bin/bash
# Silly bash script that filters all processes that are forks of each other
# Do this by either checking everything that has the same PPID, or processes
# where the PPID is the PID of another process