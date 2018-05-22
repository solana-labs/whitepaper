#!/bin/bash -e

cd $(dirname $0)/..
(
  set -x
  pdflatex -interaction=nonstopmode -halt-on-error *.tex
)

# TODO: rename main.tex then remove this line
mv main.pdf solana-whitepaper.pdf

exit 0
