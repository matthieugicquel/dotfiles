#!/usr/bin/env zsh

path+=/usr/local/bin

echo "⌛$(date +'%d/%m/%y %H:%M') | Running weekly housekeeping script"

trash $HOME/Downloads/*(Naw+4) # Files or folders not accessed in the last 4 weeks

sleep 10 # To avoid being blacklisted by launchd for "crashing"
