#!/bin/sh
# mquote MSG - format MSG as a quotation

: ${from:=$(mhdr -d -h x-original-from "$1")}
: ${from:=$(mhdr -d -h from "$1")}
: ${from:=Someone}

printf 'Quoth %s:\n' "$from"
{ mshow -R "$1" || mshow -h '' -N "$1"; } |
  sed -n '/^-- $/,$!p'                    | # strip signature
  sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'   | # strip empty lines
  sed 's/^/> /'                             # prefix with >
