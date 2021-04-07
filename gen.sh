#!/bin/bash

SRC="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pushd $SRC &> /dev/null

LOGO=usql
OPTIMIZED=${LOGO}-optimized
MINIMIZED=${LOGO}-minimized
WIDTH=230
HEIGHT=80

# optimize
svgo \
  --pretty \
  --indent=2 \
  --precision=4 \
  --output=$OPTIMIZED.svg \
  ${LOGO}.svg

# remove width + height attributes and convert to viewBox
#perl -pi -e 's/ (width|height)="100%"//g' $OPTIMIZED.svg
#perl -pi -e 's/width="90" height="90"/viewBox="0 0 90 90"/' $OPTIMIZED.svg

# minimize
svgo \
  --precision=4 \
  --output=$MINIMIZED.svg \
  $OPTIMIZED.svg

# generate png
inkscape \
  --export-area-page \
  --export-width=$WIDTH \
  --export-height=$HEIGHT \
  --export-type=png \
  -o $LOGO.png \
  $LOGO.svg

popd &> /dev/null
