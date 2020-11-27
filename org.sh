#!/usr/bin/bash

# This shows the organization of a LaTeX file.

awk '/\\s/ {print $0}' $1 | sed 's/\\section//g; s/\\subsection/\t/g; s/\\subsubsection/\t\t/g'

