#!/usr/bin/bash

# This takes a PDF and embeds fonts using GhostScript 

newname=$(echo $1 | sed 's/\./\_embedded\./g')
gs -q -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -sDEVICE=pdfwrite -sOutputFile=$newname $1





