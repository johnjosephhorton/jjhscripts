#!/usr/bin/bash

# This finds all the graphics in a LaTeX file, including those that are commmented out.

grep 'includegraphics' $1 | sed 's/.*{\([^}]*\).*/ \1/p' | sort | uniq
